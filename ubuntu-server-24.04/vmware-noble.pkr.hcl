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
  default = true
}

locals {
  shutdown_command = "sudo shutdown -h now"
}

# Ubuntu Noble configuration
source "vmware-iso" "ubuntu-noble" {
  iso_url      = "https://cdimage.ubuntu.com/releases/24.04.1/release/ubuntu-24.04.1-live-server-arm64.iso"
  iso_checksum = "md5:606cfbbab4742ab34154e91bb0b26777"
  vm_name      = "Ubuntu Server 24.04.1"
  
  ssh_username        = var.ssh_username
  ssh_password        = var.ssh_password
  ssh_timeout         = var.ssh_timeout
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
  name = "ubuntu-noble-arm64"
  
  sources = ["sources.vmware-iso.ubuntu-noble"]
  
  provisioner "shell" {
    scripts = [
      "../scripts/add-vagrant-key.sh",
      "vmware-cleanup.sh"
    ]
  }
  
  post-processor "vagrant" {
    output = "output/vmware-noble-arm64.box"
    compression_level = 9
    keep_input_artifact = false
    provider_override = "vmware"
    architecture = "arm64"

    vagrantfile_template_generated = true
  }
}