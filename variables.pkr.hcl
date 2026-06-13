variable "vcenter_server" {
    description = "The vCenter server to connect to."
    type        = string
}

variable "vcenter_username" {
    description = "The username to connect to the vCenter server."
    type        = string
}

variable "vcenter_password" {
    description = "The password to connect to the vCenter server."
    type        = string
    sensitive   = true
}

variable "datacenter" {
    description = "The datacenter in which to create the VM."
    type        = string
}

variable "cluster" {
    description = "The cluster in which to create the VM."
    type        = string
}