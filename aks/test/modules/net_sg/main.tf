resource "azurerm_network_security_group" "nsg" {
for_each = var.netsgs
  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name

  
  tags = {
    environment = "Test"
  }
}

resource "azurerm_network_security_rule" "srules" {
	count = length(local.sg_details)
	name = 							local.sg_details[count.index].name
	priority = 						local.sg_details[count.index].priority
	access = 						local.sg_details[count.index].access
	protocol = 						local.sg_details[count.index].protocol
    direction = 					local.sg_details[count.index].direction
	source_port_range = 			local.sg_details[count.index].source_port_range
	destination_port_range = 		local.sg_details[count.index].destination_port_range
	source_address_prefix = 		local.sg_details[count.index].source_address_prefix
	destination_address_prefix = 	local.sg_details[count.index].destination_address_prefix
    network_security_group_name = local.sg_details[count.index].security_group_name
    resource_group_name = var.resource_group_name
    depends_on = [
		azurerm_network_security_group.nsg
	]
}

	
