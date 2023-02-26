#Associate Security groupe with Privatesubnet
resource "azurerm_subnet_network_security_group_association" "SGRASSOS2" {
  subnet_id = azurerm_subnet.PrivateSubnet.id
  network_security_group_id = azurerm_network_security_group.SecurityGroupSubnet.id
}

#Associate Security groupe with the Network interfaces 1 (Vm1)
resource "azurerm_network_interface_security_group_association" "SGRASSOS1" {
  network_interface_id      = azurerm_network_interface.network_interface_1.id
  network_security_group_id = azurerm_network_security_group.SecurityGroup.id
}


#Associate Security groupe with the Network interfaces 2 (Vm2)
resource "azurerm_network_interface_security_group_association" "SGRASSOS2" {
  network_interface_id      = azurerm_network_interface.network_interface_2.id
  network_security_group_id = azurerm_network_security_group.SecurityGroup.id
}
