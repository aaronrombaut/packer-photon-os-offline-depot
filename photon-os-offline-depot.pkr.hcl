packer {
  required_plugins {
    vmware = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/vmware"
    }
  }
}

source "vsphere-iso" "photon" {
  
  iso_url      = var.iso_path
  iso_checksum = "sha256:691D09EB61F8CAD470F21C88287FF6B005C3BE365C926A87577E714AEE2D46BC"

  vm_name       = var.vm_name
  guest_os_type = "vmware-photon-64"
  firmware      = "efi"

  cpus   = var.cpus
  memory = var.memory

  disk_size = 40960
  disk_additional_size = [
    1048576
  ]

  disk_adapter_type = "scsi"
  disk_type_id      = 0

  network_adapters {
    network      = "dvPG-VLAN106-Core Services"
    network_card = "vmxnet3"
  }

  communicator = "ssh"
  ssh_username = var.ssh_username
  ssh_password = var.ssh_password
  ssh_timeout  = "30m"

  shutdown_command = "shutdown -h now"

  headless = false

  http_directory = "http"

  boot_wait = "5s"
  boot_command = [
    "<wait5>",
    "e<wait>",
    " ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/photon-ks.json<wait>",
    "<enter><wait>",
    "<enter>"
  ]
}

build {
  sources = ["source.vmware-iso.photon"]

  content_library_destination {
    library = "General Purpose"
  }
}