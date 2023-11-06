# Configure the Microsoft Azure Provider
provider "azurerm" {
}


module "resource_group" {
  source   = "../modules/resource_group"
  location = var.location
}

module "virtual_network" {
  source              = "../modules/virtual_network"
  location            = var.location
  resource_group_name = module.resource_group.name
}

module "linux_virtual_machine" {
  source                = "../modules/linux_virtual_machine"
  location              = var.location
  vnetwork_interface_id = module.virtual_network.nic
  resource_group_name   = module.resource_group.name
  sshkey                = var.sshkey

}


module "storage_account" {
  source              = "../modules/storage_account"
  location            = var.location
  resource_group_name = module.resource_group.name
}
