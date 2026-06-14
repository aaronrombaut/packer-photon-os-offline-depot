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

variable "datastore" {
  description = "The datastore where the VM will be created."
  type        = string
}

variable "network" {
  description = "The vSphere network or distributed port group for the VM."
  type        = string
  default     = "dvPG-VLAN106-Core Services"
}

variable "iso_path" {
  description = "Content Library or datastore ISO path."
  type        = string
  default     = "General Purpose/photon-minimal-5.0-dde71ec57.x86_64/photon-minimal-5.0-dde71ec57.x86_64.iso"
}

variable "vm_name" {
  description = "The name of the VM created by Packer."
  type        = string
  default     = "photon-offline-depot"
}

variable "folder" {
  description = "The vSphere VM folder."
  type        = string
  default     = ""
}

variable "disk_size" {
  description = "The size of the VM's disk in MB."
  type        = number
  default     = 40960
}

variable "additional_disk_size" {
  description = "The size of the additional disk in MB."
  type        = number
  default     = 1048576
}