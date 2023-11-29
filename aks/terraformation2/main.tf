resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "peanolab"
}

module "virtual_net" {
  source ="./modules/virtual_net"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnets = var.subnets
}
module "net_sg" {
  source = "./modules/net_sg"
  netsgs = var.netsgs
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

module "aks" {
 source = "./modules/aks"
 location = azurerm_resource_group.rg.location
 resource_group_name = azurerm_resource_group.rg.name
 name = "k8speano"
}