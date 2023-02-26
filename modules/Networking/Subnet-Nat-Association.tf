#Associer le PrivateSubnet subnet privé <==> nat gateway
resource "azurerm_subnet_nat_gateway_association" "Subnet_assos_Nat" {
  subnet_id      = azurerm_subnet.PrivateSubnet.id
  nat_gateway_id = azurerm_nat_gateway.Nat-gateway.id
}