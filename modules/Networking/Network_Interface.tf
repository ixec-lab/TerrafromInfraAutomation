#########----Creation de 2 network interfaces pour les attribuer par la suite aux 2 instance (vm)----######

#Network interface1
resource "azurerm_network_interface" "network_interface_1" {
  name                = "network_interface"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.PrivateSubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

#Network interface2
resource "azurerm_network_interface" "network_interface_2" {
  name                = "network_interface2"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.PrivateSubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}