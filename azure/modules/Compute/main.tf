
#########----Creation de 2 network interfaces pour les attribuer par la suite aux 2 instance (vm)----######

#Network interface1
resource "azurerm_network_interface" "network_interface_1" {
  name                = "network_interface"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
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
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

###########---- creation des deux Vm -----###########

#Creation de la VM1
resource "azurerm_linux_virtual_machine" "VM1" {
  name                = var.vm1_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_D2s_v3"
  admin_username      = "adminuser"
  admin_password = "Adminuser.2022"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.network_interface_1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

   custom_data = base64encode(var.provisionning)
}

#Creation de la VM2
resource "azurerm_linux_virtual_machine" "VM2" {
  name                = var.vm2_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_D2s_v3"
  admin_username      = "adminuser2"
  admin_password = "Adminuser.2022"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.network_interface_2.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  custom_data = base64encode(var.provisionning)

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
