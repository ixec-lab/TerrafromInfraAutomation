###########---- creation des deux Vm -----###########

#Creation de la VM1
resource "azurerm_linux_virtual_machine" "VM1" {
  name                = "VM1"
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
  name                = "VM2"
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
