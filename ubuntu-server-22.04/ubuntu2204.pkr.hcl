packer {
  required_version = ">= 1.8.5"
  required_plugins {
    vmware = {
      version = ">= 1.0.7"
      source  = "github.com/hashicorp/vmware"
    }
  }
}

locals {
  data_source_content = {
    "/meta-data" = file("${abspath(path.root)}/data/meta-data")
    "/user-data" = templatefile("${abspath(path.root)}/data/user-data.pkrtpl.hcl", {
      vm_guest_os_language     = var.vm_guest_os_language
      vm_guest_os_keyboard     = var.vm_guest_os_keyboard
      vm_guest_os_timezone     = var.vm_guest_os_timezone
    })
  }
}

source "vmware-iso" "ubuntu-server-2204" {
  // Optional configuration
  // https://developer.hashicorp.com/packer/plugins/builders/vmware/iso#optional
  disk_size     = var.disk_size
  guest_os_type = var.guest_os_type
  version       = var.vmx_hardware_version
  vm_name       = var.vm_name

  // Extra disk configuration
  // https://developer.hashicorp.com/packer/plugins/builders/vmware/iso#extra-disk-configuration
  disk_adapter_type = var.disk_adapter_type
  disk_type_id      = var.disk_type_id

  // ISO configuration
  // https://developer.hashicorp.com/packer/plugins/builders/vmware/iso#iso-configuration
  iso_checksum = var.iso_checksum
  iso_url      = var.iso_url

  // HTTP configuration
  // https://developer.hashicorp.com/packer/plugins/builders/vmware/iso#http-directory-configuration
  http_content = local.data_source_content

  // Shutdown configuration
  // https://developer.hashicorp.com/packer/plugins/builders/vmware/iso#shutdown-configuration
  shutdown_command = "sudo shutdown -h now"

  // Hardware configuration
  // https://developer.hashicorp.com/packer/plugins/builders/vmware/iso#hardware-configuration
  cpus   = var.cpus
  memory = var.memory
  usb    = true

  // Output configuration
  // https://developer.hashicorp.com/packer/plugins/builders/vmware/iso#output-configuration
  output_directory = "artifacts"

  // VMX configuration
  // https://developer.hashicorp.com/packer/plugins/builders/vmware/iso#vmx-configuration
  vmx_data = {
    "ethernet0.virtualdev" = "e1000e"
    "usb_xhci.present"     = "true"
  }

  // SSH configuration
  // https://developer.hashicorp.com/packer/plugins/builders/vmware/iso#optional-ssh-fields
  ssh_username = "vagrant"
  ssh_password = "vagrant"
  ssh_timeout  = var.ssh_timeout

  // Boot configuration
  // https://developer.hashicorp.com/packer/plugins/builders/vmware/iso#boot-configuration
  boot_command = [
    "c",
    "linux /casper/vmlinuz \"ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/\" --- autoinstall",
    "<enter>",
    "initrd /casper/initrd",
    "<enter>",
    "boot",
    "<enter><wait>"
  ]
}

build {
  sources = ["sources.vmware-iso.ubuntu-server-2204"]

  provisioner "shell" {
    scripts = [
      "scripts/post-install.sh"
    ]
  }
}
