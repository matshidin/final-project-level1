# Create a resource group if it doesn’t exist
provider "azurerm" {

  features {}

}
resource "azurerm_resource_group" "demo2" {
  name     = "final-lab-demo2"
  location = var.location
}
