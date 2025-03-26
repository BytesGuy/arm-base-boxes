packer {
  required_plugins {
    vmware = {
      source  = "github.com/hashicorp/vmware"
      version = ">= 1.1.0"
    }
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = ">= 1.0.2"
    }
  }
}

# Include common variables
variable "ssh_username" {
  type    = string
  default = "vagrant"
}
variable "ssh_password" {
  type    = string
  default = "vagrant"
}
variable "ssh_timeout" {
  type    = string
  default = "30m"
}
variable "cpu_count" {
  type    = number
  default = 2
}
variable "memory" {
  type    = number
  default = 2048
}
variable "disk_size" {
  type    = number
  default = 40000
}
variable "vm_version" {
  type    = number
  default = 21
}
variable "headless" {
  type    = bool
  default = false
}

locals {
  shutdown_command = "sudo shutdown -h now"
}

source "vmware-iso" "ubuntu-focal" {
  iso_url      = "https://cdimage.ubuntu.com/releases/20.04/release/ubuntu-20.04.5-live-server-arm64.iso"
  iso_checksum = "file:https://cdimage.ubuntu.com/releases/20.04/release/SHA256SUMS"
  vm_name      = "Ubuntu Server 20.04.5"
  
  ssh_username        = var.ssh_username
  ssh_password        = var.ssh_password
  ssh_timeout        = var.ssh_timeout
  shutdown_command    = local.shutdown_command
  guest_os_type      = "arm-ubuntu-64"
  disk_adapter_type  = "nvme"
  version            = var.vm_version
  http_directory     = "http"
  network_adapter_type = "e1000e"
  usb                = true
  memory             = var.memory
  cpus               = var.cpu_count
  disk_size          = var.disk_size
  headless           = var.headless
  output_directory   = "packer"
  
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
  name = "ubuntu-focal-arm64"
  
  sources = ["sources.vmware-iso.ubuntu-focal"]
  
  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y open-vm-tools-desktop"
    ]
  }
  
  provisioner "shell" {
    scripts = [
      "../scripts/add-vagrant-key.sh",
      "../scripts/cleanup.sh",
      "../scripts/vmware-optimisation.sh"
    ]
  }
  
  post-processor "vagrant" {
    output = "output/vmware-focal-arm64.box"
    compression_level = 9
    keep_input_artifact = false
    provider_override = "vmware"
    architecture = "arm64"
    vagrantfile_template_generated = true
  }
}