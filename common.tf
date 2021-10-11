# Resource group section.
locals {
  rg_name = "yael_proj_rg"
  all_resources_location = "West Europe"
}

resource "azurerm_resource_group" "yael_proj_rg" {
  name     = local.rg_name
  location = local.all_resources_location
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
