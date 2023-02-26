#Creation de l'ip du load balancer
resource "azurerm_public_ip" "LB-ip" {
  name                = "LB-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}