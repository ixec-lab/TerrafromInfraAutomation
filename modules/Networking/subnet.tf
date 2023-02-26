#Creation du PublicSubnet (public)
resource "azurerm_subnet" "PublicSubnet" {
  name                 = "PublicSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}

#Creation du PrivateSubnet (privé)
resource "azurerm_subnet" "PrivateSubnet" {
  name                 = "PrivateSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}