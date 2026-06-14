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

variable "vm_name" {
    description = "The name of the VM to create."
    type        = string
}

variable "memory" {
    description = "The amount of memory to allocate to the VM."
    type        = number
}

variable "cpus" {
    description = "The number of CPUs to allocate to the VM."
    type        = number
}

variable "ssh_username" {
    description = "The username for SSH access to the VM."
    type        = string
}

variable "ssh_password" {
    description = "The password for SSH access to the VM."
    type        = string
    sensitive   = true
}

variable "iso_path" {
    description = "The path to the ISO file for the VM."
    type        = string
}