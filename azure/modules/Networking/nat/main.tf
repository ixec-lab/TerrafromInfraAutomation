#Creation d'une adresse ip pour l'attribuer ensuite au nat gateway
resource "azurerm_public_ip" "Nat-ip" {
  name                = "Nat-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

#Creation du Nat gateway
resource "azurerm_nat_gateway" "Nat-gateway" {
  name                    = "Nat-gateway"
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name            = "Standard"
}

#Association de la @ ip avec Nat gateway
resource "azurerm_nat_gateway_public_ip_association" "Ip_assos_Nat" {
  nat_gateway_id       = azurerm_nat_gateway.Nat-gateway.id
  public_ip_address_id = azurerm_public_ip.Nat-ip.id
}

#Associer le PrivateSubnet subnet privé <==> nat gateway
resource "azurerm_subnet_nat_gateway_association" "Subnet_assos_Nat" {
  subnet_id      = var.Privatesubnet_id
  nat_gateway_id = azurerm_nat_gateway.Nat-gateway.id
}
