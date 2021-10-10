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

# Hub vnet section.
locals {
  hub_vnet_address = "10.0.0.0/16"
  hub_vnet_name = "hub-vnet"
}

resource "azurerm_virtual_network" "hub_vnet" {
  name                = local.hub_vnet_name
  location            = local.all_resources_location
  resource_group_name = local.rg_name
  address_space       = [local.hub_vnet_address]

  depends_on = [azurerm_resource_group.yael_proj_rg]
}

# Subnet of the hub vnet (a vm will be in it).
locals {
  hub_vm_subnet_name = "hub_vm_subnet"
  hub_vm_subnet_address = "10.0.3.0/24"
}

resource "azurerm_subnet" "hub_vm_subnet" {
  name                 = local.hub_vm_subnet_name
  resource_group_name  = local.rg_name
  virtual_network_name = local.hub_vnet_name
  address_prefixes     = [local.hub_vm_subnet_address]

  depends_on = [azurerm_virtual_network.hub_vnet]
}

locals {
  firewall_subnet_name = "AzureFirewallSubnet"
  firewall_subnet_address = "10.0.4.0/26"
}
resource "azurerm_subnet" "hub_AzureFirewallSubnet" {
  name                 = local.firewall_subnet_name
  resource_group_name  = local.rg_name
  virtual_network_name = local.hub_vnet_name
  address_prefixes     = [local.firewall_subnet_address]

  depends_on = [azurerm_virtual_network.hub_vnet]
}

# Vm in the hub section.
locals {
  hub_nic_name   = "hub-vm-nic"
  hub_vm_name = "hub-vm"
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

# Gw of the hub vnet, with public ip and a subnet section.
locals {
  hub_gw_subnet_address = "10.0.2.0/24"
  hub_gw_subnet_name = "GatewaySubnet"
  hub_gw_name    = "hub-gw"
  hub_gw_public_ip_name = "hub-gw-public-ip"
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

# ================================================================================================================
# Spoke vnet section.
locals {
  spoke_vnet_name = "spoke-vnet"
  spoke_vnet_address = "20.0.0.0/16"
}

resource "azurerm_virtual_network" "spoke_vnet" {
  name                = local.spoke_vnet_name
  location            = local.all_resources_location
  resource_group_name = local.rg_name
  address_space       = [local.spoke_vnet_address]

  depends_on = [azurerm_resource_group.yael_proj_rg]
}

# Subnet of the spoke vnet (a vm will be in it).
locals {
  spoke_vm_subnet_name = "spoke-vm-subnet"
  spoke_vm_subnet_address = "20.0.3.0/24"
}

resource "azurerm_subnet" "spoke_vm_subnet" {
  name                 = local.spoke_vm_subnet_name
  resource_group_name  = local.rg_name
  virtual_network_name = local.spoke_vnet_name
  address_prefixes     = [local.spoke_vm_subnet_address]

  depends_on = [azurerm_virtual_network.spoke_vnet]
}

# Vm in the spoke section.
locals {
  spoke_nic_name   = "spoke-vm-nic"
  spoke_vm_name = "spoke-vm"
  spoke_vm_disk_caching = "ReadWrite"
  spoke_vm_size = "Standard_B2s"
  spoke_vm_publisher = "Canonical"
  spoke_vm_offer     = "UbuntuServer"
  spoke_vm_sku       = "16.04-LTS"
  spoke_vm_version   = "latest"
  spoke_vm_disk_storage_account_type = "Standard_LRS"
}

module "vm_of_spoke" {
  source = "./modules/vm_with_nic"
  location = local.all_resources_location
  rg_name = local.rg_name
  nic_name   = local.spoke_nic_name

  vm_name = local.spoke_vm_name

  vm_image_offer = local.spoke_vm_offer
  vm_image_publisher = local.spoke_vm_publisher
  vm_image_sku = local.spoke_vm_sku
  vm_image_version = local.spoke_vm_version
  vm_disk_caching = local.spoke_vm_disk_caching
  vm_disk_storage_account_type = local.spoke_vm_disk_storage_account_type

  vm_size = local.spoke_vm_size
  vm_subnet_id = azurerm_subnet.spoke_vm_subnet.id

  depends_on = [azurerm_subnet.spoke_vm_subnet]
}

#Nsg of spoke section.
resource "azurerm_network_security_group" "spoke_nsg" {
  name                = "Spoke_subnet_security_group"
  location            = local.all_resources_location
  resource_group_name = local.rg_name

  security_rule {
    name                       = "allow_TCP_in"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_ICMP_in"
    priority                   = 115
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "deny_all_in"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  depends_on = [azurerm_resource_group.yael_proj_rg]
}

resource "azurerm_subnet_network_security_group_association" "spoke_nsg_association" {
  subnet_id                 = azurerm_subnet.spoke_vm_subnet.id
  network_security_group_id = azurerm_network_security_group.spoke_nsg.id

  depends_on = [azurerm_subnet.spoke_vm_subnet, azurerm_network_security_group.spoke_nsg]
}

# Peering the hub and spoke vnets.
resource "azurerm_virtual_network_peering" "peer_hub_to_spoke" {
  name                      = "peer_hub_to_spoke"
  resource_group_name       = azurerm_resource_group.yael_proj_rg.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_vnet.id

  depends_on = [azurerm_virtual_network.hub_vnet, azurerm_virtual_network.spoke_vnet]
}

resource "azurerm_virtual_network_peering" "peer_spoke_to_hub" {
  name                      = "peer_spoke_to_hub"
  resource_group_name       = azurerm_resource_group.yael_proj_rg.name
  virtual_network_name      = azurerm_virtual_network.spoke_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id

  depends_on = [azurerm_virtual_network.hub_vnet, azurerm_virtual_network.spoke_vnet]
}

# ==============================================================

locals {
  firewall_public_ip_allocation_method = "Static"
  firewall_public_ip_name = "firewall_public_ip"
  firewall_sku                 = "Standard"

}

resource "azurerm_public_ip" "firewall_public_ip" {
  name                = local.firewall_public_ip_name
  location            = local.all_resources_location
  resource_group_name = local.rg_name
  allocation_method = local.firewall_public_ip_allocation_method
  sku                 = local.firewall_sku

  depends_on = [azurerm_resource_group.yael_proj_rg]
}

locals {
  firewall_policy_name = "firewall_hub_policy"
}

resource "azurerm_firewall_policy" "firewall_policy" {
  name                = local.firewall_policy_name
  resource_group_name = local.rg_name
  location            = local.all_resources_location //"West Europe"

  threat_intelligence_mode = "Deny"

  depends_on = [azurerm_resource_group.yael_proj_rg]
}

resource "azurerm_firewall" "firewall" {
  name                = "hub_firewall"
  location            = local.all_resources_location
  resource_group_name = local.rg_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.hub_AzureFirewallSubnet.id
    public_ip_address_id = azurerm_public_ip.firewall_public_ip.id
  }

  depends_on = [azurerm_public_ip.firewall_public_ip]
}

resource "azurerm_firewall_network_rule_collection" "network_rule_collection" {
  name                = "testcollection"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = local.rg_name
  priority            = 200
  action              = "Allow"

  rule {
    name = "testrule"

    source_addresses = [
      "10.0.0.0/16",
    ]

    destination_ports = [
      "22",
    ]

    destination_addresses = [
      "20.0.0.0/16",
    ]

    protocols = [
      "TCP"
    ]
  }
}

# =========================================

resource "azurerm_route_table" "example" {
  name                          = "acceptanceTestSecurityGroup1"
  location                      = local.all_resources_location
  resource_group_name           = local.rg_name
  disable_bgp_route_propagation = false

  route {
    name           = "route1"
    address_prefix = "10.0.0.0/16"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  }

    route {
    name           = "route2"
    address_prefix = "20.0.0.0/16"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  }

  depends_on = [azurerm_public_ip.firewall_public_ip]
}

resource "azurerm_subnet_route_table_association" "hub_route_table_association" {
  route_table_id = azurerm_route_table.example.id
  subnet_id      = azurerm_subnet.hub_vm_subnet.id
}

resource "azurerm_subnet_route_table_association" "spoke_route_table_association" {
  route_table_id = azurerm_route_table.example.id
  subnet_id      = azurerm_subnet.spoke_vm_subnet.id
}

