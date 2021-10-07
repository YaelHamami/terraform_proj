# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

#Configure the Microsoft Azure Provider.
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

#Resource groupe section.
locals {
  rg_name = "yael-proj-rg"
  all_resources_location = "West Europe"
}

resource "azurerm_resource_group" "yael-proj-rg" {
  name     = local.rg_name
  location = local.all_resources_location
}

#Hub vnet section.
locals {
  hub_vnet_address = "10.0.0.0/16"
  hub_vnet_name = "yael-proj-gw-vnet"
}

resource "azurerm_virtual_network" "hub_vnet" {
  name                = local.hub_vnet_name
  location            = local.all_resources_location
  resource_group_name = local.rg_name
  address_space       = [local.hub_vnet_address]

  depends_on = [azurerm_resource_group.yael-proj-rg]
}

#subnet of the hub vnet (a vm will be in it).
locals {
  hub_vm_subnet_name = "yael-proj-vm-subnet"
  hub_vm_subnet_address = "10.0.3.0/24"
}

resource "azurerm_subnet" "hub_vm_subnet" {
  name                 = local.hub_vm_subnet_name
  resource_group_name  = local.rg_name
  virtual_network_name = local.hub_vnet_name
  address_prefixes     = [local.hub_vm_subnet_address]

  depends_on = [azurerm_virtual_network.hub_vnet]
}

#Vm in the hub section.
locals {
  hub_nic_name   = "yael-proj-nic"
  hub_vm_name = "yael-proj-vm"
  hub_vm_disk_caching = "ReadWrite"
  hub_vm_size = "Standard_B2s"
  hub_vm_publisher = "Canonical"
  hub_vm_offer     = "UbuntuServer"
  hub_vm_sku       = "16.04-LTS"
  hub_vm_version   = "latest"
  hub_vm_disk_storage_account_type = "Standard_LRS"
}

module "vm_of_hub" {
  source = "./modules/vm_with_nic"
  location = local.all_resources_location
  rg_name = local.rg_name
  nic_name   = local.hub_nic_name

  vm_name = local.hub_vm_name

  vm_image_offer = local.hub_vm_offer
  vm_image_publisher = local.hub_vm_publisher
  vm_image_sku = local.hub_vm_sku
  vm_image_version = local.hub_vm_version
  vm_disk_caching = local.hub_vm_disk_caching
  vm_disk_storage_account_type = local.hub_vm_disk_storage_account_type

  vm_size = local.hub_vm_size
  vm_subnet_id = azurerm_subnet.hub_vm_subnet.id

  depends_on = [azurerm_subnet.hub_vm_subnet]
}

#Gw of the hub vnet, with public ip and a subnet section.
locals {
  hub_gw_subnet_address = "10.0.2.0/24"
  hub_gw_subnet_name = "GatewaySubnet"
  hub_gw_name    = "yael-proj-gw"
  hub_gw_public_ip_name = "yael-proj-public-ip"
  hub_gw_vpn_address_space = ["10.2.0.0/24"]
}

module "gw_with_subnet" {
  source = "./modules/gw_with_subnet"

  location = local.all_resources_location
  rg_name = local.rg_name

  vnet_name = azurerm_virtual_network.hub_vnet.name

  gw_subnet_address = local.hub_gw_subnet_address
  gw_subnet_name = local.hub_gw_subnet_name

  gw_name    = local.hub_gw_name
  gw_vpn_address_space = local.hub_gw_vpn_address_space
  gw_public_ip_name = local.hub_gw_public_ip_name

  aad_audience_gw = var.aad_audience_gw
  aad_issuer_gw = var.aad_issuer_gw
  aad_tenant_gw = var.aad_tenant_gw

  depends_on = [azurerm_virtual_network.hub_vnet]
}