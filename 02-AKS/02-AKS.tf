resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "aks-cluster"
  location            = var.location
  resource_group_name = var.resource_group
  dns_prefix          = "aks-cluster"


  default_node_pool {
    name    = "systempool"
    vm_size = "Standard_B2s"


    vnet_subnet_id      = var.subnet_id
    zones               = [2]
    enable_auto_scaling = true
    max_count           = 3
    min_count           = 1
    os_disk_size_gb     = 30
    type                = "VirtualMachineScaleSets"
    node_labels = {
      "nodepool-type" = "system"
      "environment"   = "dev"
      "nodepoolos"    = "linux"
      "app"           = "system-apps"
    }
    tags = {
      "nodepool-type" = "system"
      "environment"   = "dev"
      "nodepoolos"    = "linux"
      "app"           = "system-apps"
    }
  }

  identity {
    type = "SystemAssigned"

  }
  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    network_policy    = "calico"
  }

}

