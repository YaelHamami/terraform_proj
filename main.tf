# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

locals {
  rg_name = "yael-proj-rg"
  all_resources_location = "West Europe"
}

resource "azurerm_resource_group" "yael-proj-rg" {
  name     = local.rg_name
  location = local.all_resources_location
}

locals {
  hub_vnet_address = "10.0.0.0/16"
  hub_vnet_name = "yael-proj-gw-vnet"
  hub_gw_subnet_address = "10.0.2.0/24"
  hub_gw_subnet_name = "GatewaySubnet"
  hub_vm_subnet_name = "yael-proj-vm-vnet"
  hub_vm_subnet_address = "10.0.3.0/24"

  hub_nic_name   = "yael-proj-nic"
  hub_vm_name = "yael-proj-vm"
  hub_vm_disk_caching = "ReadWrite"
  hub_vm_size = "Standard_B2s"
  hub_vm_publisher = "Canonical"
  hub_vm_offer     = "UbuntuServer"
  hub_vm_sku       = "16.04-LTS"
  hub_vm_version   = "latest"
  hub_vm_disk_storage_account_type = "Standard_LRS"

  hub_gw_name    = "yael-proj-gw"
  hub_gw_public_ip_name = "yael-proj-public-ip"
  hub_gw_vpn_address_space = ["10.2.0.0/24"]
}

module "hub_with_vm" {
  source = "./modules/vnet&vm"

  location = local.all_resources_location
  rg_name = local.rg_name

  vnet_address = local.hub_vnet_address
  vnet_name = local.hub_vnet_name
  gw_subnet_address = local.hub_gw_subnet_address
  gw_subnet_name = local.hub_gw_subnet_name
  vm_subnet_name = local.hub_vm_subnet_name
  vm_subnet_address = local.hub_vm_subnet_address

  nic_name   = local.hub_nic_name
  vm_name = local.hub_vm_name
  vm_disk_caching = local.hub_vm_disk_caching
  vm_size = local.hub_vm_size
  vm_image_offer = local.hub_vm_offer
  vm_image_publisher = local.hub_vm_publisher
  vm_image_sku = local.hub_vm_sku
  vm_image_version = local.hub_vm_version
  vm_disk_storage_account_type = local.hub_vm_disk_storage_account_type

  gw_name    = local.hub_gw_name
  gw_vpn_address_space = local.hub_gw_vpn_address_space
  gw_public_ip_name = local.hub_gw_public_ip_name

  aad_audience_gw = var.aad_audience_gw
  aad_issuer_gw = var.aad_issuer_gw
  aad_tenant_gw = var.aad_tenant_gw

  depends_on = [azurerm_resource_group.yael-proj-rg]
}