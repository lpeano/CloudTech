resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "peanolab"
}

resource "azurerm_virtual_network" "peano-private-network" {
  name                = "peano-private-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
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

module "net_sg" {
  source = "./modules/net_sg"
  netsgs = var.netsgs
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
