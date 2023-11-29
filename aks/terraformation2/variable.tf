variable "resource_group_location" {
  type        = string
  default     = "italynorth"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 2
}

variable "msi_id" {
  type        = string
  description = "The Managed Service Identity ID. Set this value if you're running this example using Managed Identity as the authentication method."
  default     = null
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster."
  default     = "azureadmin"
}


variable "subnets" {
  type	= map(any)
  default = {
  	aks-net = {
		name = "aks-net"
		subnet = "10.0.2.0/24"
		resource_group = "peanolab"
	}
	filrewall-net = {
		name = "firewall-net"
		subnet = "10.0.1.0/24"
		resource_group = "peanolab"
	}
  }
}
		

variable "netsgs" {
	type = map(any)
	default ={ 
		nsg-aks = {
			name = "nsg-aks"
		}
	}
}