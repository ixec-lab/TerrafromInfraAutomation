#Creation d'une adresse ip pour l'attribuer ensuite au nat gateway
resource "azurerm_public_ip" "Nat-ip" {
  name                = "Nat-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}