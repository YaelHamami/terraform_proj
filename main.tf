# Azure Provider source and version being used.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider.
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Resource group section.
locals {
  rg_name = "yael_proj_rg"
  all_resources_location = "West Europe"
}

resource "azurerm_resource_group" "yael_proj_rg" {
  name     = local.rg_name
  location = local.all_resources_location
}

