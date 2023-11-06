provider "azurerm" {

  features {}

}

terraform {
  backend "azurerm" {
    resource_group_name  = "remote-state"
    storage_account_name = "terraformstateshidee95"
    container_name       = "terraform-state-module"
    key                  = "terraform.tfstate"
  }
}


# Create linux virtual machine

resource "azurerm_linux_virtual_machine" "os_linux_instance" {
  name                = "${var.prefix}-linuxvm-module"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    var.vnetwork_interface_id,
  ]


  os_disk {
    name                 = "myosdisk1"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }


  admin_ssh_key {
    username   = "adminuser"
    public_key = file(var.sshkey)

  }
  depends_on = [
    tls_private_key.linux_key
  ]

}


resource "tls_private_key" "linux_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "linuxkey" {
  filename = "linuxkey.pem"
  content  = tls_private_key.linux_key.private_key_pem


}
