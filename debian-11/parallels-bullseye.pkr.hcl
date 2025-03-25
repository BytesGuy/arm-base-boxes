packer {
  required_plugins {
    parallels = {
      source  = "github.com/hashicorp/parallels"
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
variable "headless" {
  type    = bool
  default = true
}

locals {
  shutdown_command = "sudo shutdown -h now"
}

source "parallels-iso" "debian-bullseye" {
  iso_url      = "https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-11.3.0-arm64-netinst.iso"
  iso_checksum = "md5:1fb24715f545447aff432e543436e57d"
  vm_name      = "Debian 11"
  
  ssh_username        = var.ssh_username
  ssh_password        = var.ssh_password
  ssh_timeout        = var.ssh_timeout
  shutdown_command    = local.shutdown_command
  guest_os_type      = "debian"
  http_directory     = "http"
  memory             = var.memory
  cpus               = var.cpu_count
  disk_size          = var.disk_size
  headless           = var.headless
  output_directory   = "packer"
  parallels_tools_flavor = "lin-arm"
  parallels_tools_mode = "upload"
  parallels_tools_guest_path = "/tmp/prltools.iso"
  
  boot_command = [
    "c",
    "linux /install.a64/vmlinuz auto=true priority=critical url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg --- quiet",
    "<enter>",
    "initrd /install.a64/initrd.gz",
    "<enter>",
    "boot",
    "<enter><wait>"
  ]
}

build {
  name = "debian-bullseye-arm64"
  
  sources = ["sources.parallels-iso.debian-bullseye"]
  
  provisioner "shell" {
    scripts = [
      "../scripts/add-vagrant-key.sh",
      "../scripts/install-parallels-tools.sh",
      "../scripts/cleanup.sh"
    ]
  }
  
  post-processor "vagrant" {
    output = "output/parallels-bullseye-arm64.box"
    compression_level = 9
    keep_input_artifact = false
    provider_override = "parallels"
    architecture = "arm64"
    vagrantfile_template_generated = true
  }
}