resource "azurerm_virtual_network" "peano-private-network" {
  name                = "peano-private-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnets
  name                 = each.value.name
  resource_group_name  = each.value.resource_group
  virtual_network_name = azurerm_virtual_network.peano-private-network.name
  address_prefixes     = [each.value.subnet]

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
  depends_on = [ azurerm_virtual_network.peano-private-network ]
}