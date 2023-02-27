#Creation du PrivateSubnet (privé)
resource "azurerm_subnet" "PrivateSubnet" {
  name                 = "PrivateSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.1.0/24"]
}

#Security groupe to make the subnet private
resource "azurerm_network_security_group" "SecurityGroupSubnet" {
  name                = "SecurityGroupSubnet"
  location            = var.location
  resource_group_name = var.resource_group_name
}


#Associate Security groupe with Privatesubnet
resource "azurerm_subnet_network_security_group_association" "SGRASSOS2" {
  subnet_id = azurerm_subnet.PrivateSubnet.id
  network_security_group_id = azurerm_network_security_group.SecurityGroupSubnet.id
}