variable "location" {
  type    = string
  default = "Southeast Asia"
}
variable "prefix" {
  type    = string
  default = "final-lab"
}


variable "resource_group_name" {
  type        = string
  default     = "final-lab-demo2"
  description = "Resource group name"
}

variable "sshkey" {
  default     = "mykey.pub"
  description = "Public SSH key's path for vm login"
}

variable "vnetwork_interface_id" {
  default     = "/subscriptions/fc8dc059-7cef-4161-95ff-20bcc6c2ef99/resourceGroups/final-lab-demo2/providers/Microsoft.Network/networkInterfaces/final-lab-linux-instance1"
  description = "Virtual network interface ID"
}



