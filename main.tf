provider "azurerm" {
  features {}
  subscription_id = "83e88fbe-e51b-4bde-9d73-f2224a5515c8"
}

resource "azurerm_resource_group" "jm-fist" {
  name     = "my-fist"  
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "jm" {
  name                = "jm-aks1"
  location            = azurerm_resource_group.jm-fist.location
  resource_group_name = azurerm_resource_group.jm-fist.name
  dns_prefix          = "jmaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.jm.kube_config[0].client_certificate  # Se cambió "jm-fist" por "jm"
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.jm.kube_config_raw  # Se cambió "jm-fist" por "jm"
  sensitive = true
}
