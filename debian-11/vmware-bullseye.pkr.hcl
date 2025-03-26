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

source "vmware-iso" "debian-bullseye" {
  iso_url      = "https://cdimage.debian.org/cdimage/archive/11.9.0/arm64/iso-cd/debian-11.9.0-arm64-netinst.iso"
  iso_checksum = "file:https://cdimage.debian.org/cdimage/archive/11.9.0/arm64/iso-cd/SHA256SUMS"
  vm_name      = "Debian 11"
  
  ssh_username        = var.ssh_username
  ssh_password        = var.ssh_password
  ssh_timeout        = var.ssh_timeout
  shutdown_command    = local.shutdown_command
  guest_os_type      = "arm-debian11-64"
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
  
  sources = ["sources.vmware-iso.debian-bullseye"]
  
  provisioner "shell" {
    inline = [
      "wget https://packages.vmware.com/tools/open-vm-tools/ovt-arm-tech-preview/Debian-10/open-vm-tools-11.2.5-2debian10.tgz",
      "tar -zxf open-vm-tools-11.2.5-2debian10.tgz",
      "sudo dpkg -i --force-confnew ./open-vm-tools_11.2.5-2debian10_arm64.deb || true",
      "sudo apt --fix-broken install -y",
      "sudo mkdir -p /mnt/hgfs/",
      "sudo /usr/bin/vmhgfs-fuse .host:/ /mnt/hgfs/ -o subtype=vmhgfs-fuse,allow_other"
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
    output = "output/vmware-bullseye-arm64.box"
    compression_level = 9
    keep_input_artifact = false
    provider_override = "vmware"
    architecture = "arm64"
    vagrantfile_template_generated = true
  }
}