provider "azurerm" {

  features {}

}


# Create window virtual machine
resource "azurerm_windows_virtual_machine" "os_window" {
  name                = "windowvm-module"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = file("password.txt")
  network_interface_ids = [
    var.vnetwork_interface_id,
  ]




  os_disk {
    name                 = "myosdisk1"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }




}




