#Security groupe to make the subnet private
resource "azurerm_network_security_group" "SecurityGroupSubnet" {
  name                = "SecurityGroupSubnet"
  location            = var.location
  resource_group_name = var.resource_group_name
}


#Security groupe for the network interfaces (2 Vms)
resource "azurerm_network_security_group" "SecurityGroup" {
  name                = "SecurityGroup"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowHttp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}