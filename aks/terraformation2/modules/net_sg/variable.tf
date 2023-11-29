variable "netsgs" {
	type = map(any)

}

variable "location" {
	type = string
}

variable "resource_group_name" {
	type = string
}

locals {
	csv_rule_content = csvdecode(file("sgrules/rules.csv"))
	sg_details=flatten([
		for rule in local.csv_rule_content : { 
			name                       = rule.name
		    priority                   = rule.priority
		    direction                  = rule.direction
		    access                     = rule.access
		    protocol                   = rule.protocol
		    source_port_range          = rule.source_port_range
		    destination_port_range     = rule.destination_port_range
		    source_address_prefix      = rule.source_address_prefix
		    destination_address_prefix = rule.destination_address_prefix
	        security_group_name = rule.security_group_name
        }
	])
}
