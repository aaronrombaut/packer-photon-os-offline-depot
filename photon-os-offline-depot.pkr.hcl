packer {
  required_plugins {
    vsphere = {
      version = ">= 1.4.2"
      source  = "github.com/hashicorp/vsphere"
    }
  }
}

source "vsphere-iso" "photon" {
  /* vCenter Server Details */
  vcenter_server      = var.vcenter_server
  username            = var.vcenter_username
  password            = var.vcenter_password
  insecure_connection = false

  datacenter = var.datacenter
  cluster    = var.cluster
  datastore  = var.datastore
#  folder     = var.folder

  /* Virtual Machine Details */
  vm_name       = var.vm_name
  guest_os_type = "vmwarePhoton64Guest"
  firmware      = "efi-secure"

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
#  remove_cdrom = false
  cdrom_type = "sata"

  communicator = "ssh"
  ssh_username = var.ssh_username
  ssh_password = var.ssh_password
  ssh_timeout  = "30m"

  shutdown_command = "echo '${var.ssh_password}' | sudo -S /sbin/shutdown -h now"
  shutdown_timeout = "10m"

  http_directory = "http"
  http_bind_address = "10.10.92.55"

  boot_wait = "2s"
  boot_command = [
    "e<wait5>",
    "<down><down>",
    "<leftCtrlOn>e<leftCtrlOff>",
    " ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/photon-ks.cfg insecure_installation=1",
    "<f10>"
  ]
}

build {
  sources = ["source.vsphere-iso.photon"]
}