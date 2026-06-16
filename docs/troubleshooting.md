# Troubleshooting

## Overview

This document captures issues encountered while automating Photon OS 5 deployment using HashiCorp Packer and VMware vSphere. These notes are specific to the Photon OS Offline Depot Appliance project and may differ from older Photon OS documentation.

---

## Packer Validation Errors

### Unknown source type: vsphere-iso

#### Symptom

```text
Error: Unknown source type vsphere-iso
```

#### Cause

The VMware vSphere plugin for Packer is not installed.

#### Resolution

```powershell
packer init .
```

Verify the plugin was downloaded successfully.

---

## Photon Installer Cannot Read Installation Media

### Symptom

```text
Cannot proceed with the installation because the installation medium is not readable.
Ensure that you select a medium connected to a SATA interface.
```

#### Cause

Photon OS 5 expects installation media to be attached using a SATA controller.

#### Resolution

Configure the Packer builder with:

```hcl
cdrom_type = "sata"
```

---

## HTTP Kickstart Download Rejected

### Symptom

```text
Refusing to download kick start configuration from non-https URLs.
Pass insecure_installation=1
```

#### Cause

Photon OS 5 rejects HTTP kickstart URLs by default.

#### Resolution

Append the following kernel parameter:

```text
insecure_installation=1
```

Example:

```text
ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/photon-ks.cfg insecure_installation=1
```

---

## Network Configuration Failure

### Symptom

```text
AttributeError: 'list' object has no attribute 'get'
```

#### Cause

Older Photon examples use a legacy network configuration format.

#### Resolution

Use the Photon 5 network schema:

```json
"network": {
  "version": "2",
  "ethernets": {
    "eth0": {
      "dhcp4": true
    }
  }
}
```

---

## System Installs But Does Not Boot

### Symptom

```text
Booting 'Photon'

error: ../../grub-core/fs/fshelp.c:307:not a regular file
```

#### Cause

The kernel and initramfs packages were not installed.

The installer completed successfully but failed to generate a bootable system.

#### Resolution

Explicitly include:

```json
"packages": [
  "minimal",
  "linux",
  "initramfs"
]
```

---

## EFI Secure Boot Issues

### Symptom

VM fails to locate boot media or does not boot as expected.

#### Cause

Accidental use of:

```json
"bootmode": "efi-secure"
```

and/or

```hcl
firmware = "efi-secure"
```

during testing.

#### Resolution

Use standard EFI until the build process is fully validated:

```json
"bootmode": "efi"
```

```hcl
firmware = "efi"
```

---

## Content Library ISO Usage

### Notes

Photon OS installation media can be sourced from:

* VMware Content Library
* Datastore ISO file

For this project, the ISO is stored on datastore:

```text
[DML]
```

Example:

```hcl
iso_paths = [
  "[DML] ISO/photon-minimal-5.0-dde71ec57.x86_64.iso"
]
```

---

## Known Working Configuration

### Photon ISO

```text
photon-minimal-5.0-dde71ec57.x86_64.iso
```

### Packer

```text
Packer 1.15.4
```

### Firmware

```text
EFI
```

### CD-ROM

```text
SATA
```

### Required Packages

```json
[
  "minimal",
  "linux",
  "initramfs"
]
```

### Network

```json
DHCP via network version 2 schema
```
