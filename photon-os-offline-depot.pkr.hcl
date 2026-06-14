packer {
  required_plugins {
    vsphere = {
      version = ">= 1.4.2"
      source  = "github.com/hashicorp/vsphere"
    }
  }
}

source "vsphere-iso" "photon" {
  vcenter_server      = var.vcenter_server
  username            = var.vcenter_username
  password            = var.vcenter_password
  insecure_connection = false

  datacenter = var.datacenter
  cluster    = var.cluster
  datastore  = var.datastore
  folder     = var.folder

  vm_name       = var.vm_name
  guest_os_type = "vmwarePhoton64Guest"
  firmware      = "efi"

  CPUs = var.cpus
  RAM  = var.memory

  disk_controller_type = ["pvscsi"]

  storage {
    disk_size             = var.disk_size
    disk_thin_provisioned = true
  }

  storage {
    disk_size             = var.additional_disk_size
    disk_thin_provisioned = true
  }

  network_adapters {
    network      = var.network
    network_card = "vmxnet3"
  }

  iso_paths = [
    var.iso_path
  ]
  remove_cdrom = false
  cdrom_type = "sata"

  communicator = "ssh"
  ssh_username = var.ssh_username
  ssh_password = var.ssh_password
  ssh_timeout  = "30m"

  shutdown_command = "shutdown -h now"

  http_directory = "http"
  http_bind_address = "10.10.92.55"

  boot_wait = "5s"
  boot_command = [
    "<wait7>",
    "e<wait>",
    " ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/photon-ks.cfg<wait>",
    "<enter><wait>",
    "<enter>"
  ]
}

build {
  sources = ["source.vsphere-iso.photon"]
}