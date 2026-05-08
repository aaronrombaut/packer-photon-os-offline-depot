packer {
  required_plugins {
    vmware = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/vmware"
    }
  }
}

source "vmware-iso" "photon" {
  iso_url      = "C:/ISO/photon-5.iso"
  iso_checksum = "none"

  firmware = "efi"

  communicator = "ssh"

  ssh_username = "root"
  ssh_password = "VMware1!"

  shutdown_command = "shutdown -h now"

  guest_os_type = "other5xlinux-64"

  disk_size = 40960
  disk_additional_size = 100000000
  disk_adapter_type = "nvme"
  disk_type_id = 0
  memory    = 8192
  cpus      = 2

  vm_name = "photon-offline-depot"

  network = "nat"
  network_adapter_type = "vmxnet3"

  headless = false

  http_directory = "http"
  http_content = {
    "/http/" = file("http/offline-depot-ks.cfg")
  }

  boot_wait = "5s"
  boot_command = [
    "<esc><wait>",
    "linux ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/http/offline-depot-ks.cfg<enter>"
  ]
}

build {
  sources = ["source.vmware-iso.photon"]
}