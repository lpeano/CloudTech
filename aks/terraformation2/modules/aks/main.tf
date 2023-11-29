resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "K8Scluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name # th RG the single cluster entity goes is
  dns_prefix          = "k8s"
  node_resource_group = "K8S${azurerm_resource_group.rg.name}"  #  all the k8s' entities must be in fdifferent RG than where the cluster object itself is
  api_server_authorized_ip_ranges = ["REDACTED"]
  #enable_pod_security_policy      = true
  kubernetes_version  = "1.15.7"

  default_node_pool {
    name                  = "default"
    type                  = "AvailabilitySet"
    vm_size               = var.vmsize # Standard_DC2s_v2 Standard_B1ms
    enable_node_public_ip = false
    enable_auto_scaling   = false
    os_disk_size_gb       = 30
    node_count            = 1
    vnet_subnet_id        = azurerm_subnet.akspodssubnet.id
  }

  addon_profile {
    kube_dashboard { enabled = true }
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
    service_cidr      = var.aksservicecidr
    docker_bridge_cidr = var.dockercidrip
    dns_service_ip    = var.aksdns
  }

  linux_profile {
    admin_username = var.sudouser
    ssh_key { key_data = var.sshpubkey }
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  tags  = var.default-tags
}
