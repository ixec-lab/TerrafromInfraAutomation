#Creation du Nat gateway
resource "azurerm_nat_gateway" "Nat-gateway" {
  name                    = "Nat-gateway"
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name            = "Standard"
}