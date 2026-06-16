Photon OS 5.0 (photon-minimal-5.0-dde71ec57.x86_64.iso)

Required:
- SATA CD-ROM
- insecure_installation=1 for HTTP kickstart
- network.version = 2
- packages:
  - minimal
  - linux
  - initramfs

Verified:
- EFI boot
- Secure Boot enabled
- Packer 1.15.4
- vsphere plugin >= 1.4.2