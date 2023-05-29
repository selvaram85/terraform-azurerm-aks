resource "azurerm_kubernetes_cluster" "example" {
  name                = "example-aks1"
  location            = var.location
  resource_group_name = var.rgname
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

service_principal  {
    client_id = var.client_id
    client_secret = var.client_secret
  }

  tags = {
    Environment = "Production"
  }
}
