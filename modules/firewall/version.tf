# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.80.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}