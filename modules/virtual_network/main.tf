
provider "azurerm" {

  features {}

}

# Create virtual network
# The resource names in the module get prefixed by module.<module-instance-name> when instantiated
resource "azurerm_virtual_network" "demo" {
  name                = "${var.prefix}-lab2-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Create subnet
resource "azurerm_subnet" "demo-internal-1" {
  name                 = "${var.prefix}-linux-internal-1"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.demo.name
  address_prefixes     = ["10.0.2.0/24"]

}

# Create public IPs
resource "azurerm_public_ip" "public-ip" {
  name                = "PublicIp1"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"

}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "allow-ssh" {
  name                = "${var.prefix}-allow-ssh"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create network interface
resource "azurerm_network_interface" "demo-instance" {
  name                = "${var.prefix}-linux-instance1"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "instance1"
    subnet_id                     = azurerm_subnet.demo-internal-1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public-ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "demo-instance-1" {
  network_interface_id      = azurerm_network_interface.demo-instance.id
  network_security_group_id = azurerm_network_security_group.allow-ssh.id
}



