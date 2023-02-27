#Creation du PublicSubnet (public)
resource "azurerm_subnet" "PublicSubnet" {
  name                 = "PublicSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.3.0/24"]
}
