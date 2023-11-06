provider "azurerm" {

  features {}

}


# Create storage account for boot diagnostics
resource "azurerm_storage_account" "mystorageaccount" {
  name                     = "modulesafinallab"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}



resource "azurerm_storage_container" "mycontainer" {
  name                  = "training-co-${var.prefix}"
  storage_account_name  = azurerm_storage_account.mystorageaccount.name
  container_access_type = "private"
}




resource "azurerm_storage_blob" "training-file" {
  name                   = "trainingfile.txt"
  storage_account_name   = azurerm_storage_account.mystorageaccount.name
  storage_container_name = azurerm_storage_container.mycontainer.name
  type                   = "Block"
  source                 = "trainingfile.txt"
}






