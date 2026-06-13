packer {
  required_plugins {
    vmware = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/vmware"
    }
  }
}

source "vmware-iso" "photon" {
  iso_url      = "C:/iso/photon-minimal-5.0-dde71ec57.x86_64.iso"
  iso_checksum = "sha256:691D09EB61F8CAD470F21C88287FF6B005C3BE365C926A87577E714AEE2D46BC"

  vm_name       = "photon-offline-depot"
  guest_os_type = "vmware-photon-64"
  firmware      = "efi"

  cpus   = 2
  memory = 8192

  disk_size = 40960
  disk_additional_size = [
    1048576
  ]

  disk_adapter_type = "scsi"
  disk_type_id      = 0

  network              = "nat"
  network_adapter_type = "vmxnet3"

  communicator = "ssh"
  ssh_username = "root"
  ssh_password = "VMware1!"
  ssh_timeout  = "15m"

  shutdown_command = "shutdown -h now"

  headless = false

  http_directory = "http"

  boot_wait = "5s"
  boot_command = [
    "<wait5>",
    "e<wait>",
    " ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/offline-depot-ks.cfg<wait>",
    "<enter><wait>",
    "<enter>"
  ]
}

build {
  sources = ["source.vmware-iso.photon"]
}