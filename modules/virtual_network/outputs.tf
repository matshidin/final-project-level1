output "id" {
  value = "${azurerm_virtual_network.demo.id}"
}

output "name" {
  value = "${azurerm_virtual_network.demo.name}"
}

output "nic" {
  value = "${azurerm_network_interface.demo-instance.id}"
}