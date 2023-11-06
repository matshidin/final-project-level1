variable "location" {
  default = "East US"
}



variable "prefix" {
  type    = string
  default = "module-test"
}

variable "sshkey" {
  default     = "mykey.pub"
  description = "Public SSH key's path for vm login"
}
