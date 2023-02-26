#Association de la @ ip avec Nat gateway
resource "azurerm_nat_gateway_public_ip_association" "Ip_assos_Nat" {
  nat_gateway_id       = azurerm_nat_gateway.Nat-gateway.id
  public_ip_address_id = azurerm_public_ip.Nat-ip.id
}
