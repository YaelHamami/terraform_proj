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

module "hub_with_vm" {
  source = "./modules/vnet&vm"

  location = local.all_resources_location
  rg_name = local.rg_name

  vnet_address = "10.0.0.0/16"
  vnet_name = "yael-proj-gw-vnet"
  subnet_address = "10.0.2.0/24"
  subnet_name = "GatewaySubnet"
  vm_name = "yael-proj-vm"

  gw_name    = "yael-proj-gw"
  gw_public_ip_name = "yael-proj-public-ip"

  depends_on = [azurerm_resource_group.yael-proj-rg]
  nic_name   = "yael-proj-nic"
  vm_subnet_name = "yael-proj-vm-vnet"
  vm_subnet_address = "10.0.3.0/24"
}