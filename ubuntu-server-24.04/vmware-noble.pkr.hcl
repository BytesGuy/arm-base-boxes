packer {
  required_plugins {
    vmware = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/vmware"
    }
  }
}

source "vmware-iso" "ubuntu-noble" {
  iso_url = "https://cdimage.ubuntu.com/releases/24.04.1/release/ubuntu-24.04.1-live-server-arm64.iso"
  iso_checksum = "md5:606cfbbab4742ab34154e91bb0b26777"
  ssh_username = "vagrant"
  ssh_password = "vagrant"
  ssh_timeout = "30m"
  shutdown_command = "sudo shutdown -h now"
  guest_os_type = "arm-ubuntu-64"
  disk_adapter_type = "nvme"
  version = 21
  http_directory = "http"
  network_adapter_type = "e1000e"
  boot_command = [
        "c",
        "linux /casper/vmlinuz \"ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/\" --- autoinstall",
        "<enter>",
        "initrd /casper/initrd",
        "<enter>",
        "boot",
        "<enter><wait>"
  ]
  usb = true
  memory = 2048
  cpus = 2
  disk_size = 40000
  vm_name = "Ubuntu Server 24.04.1"
  output_directory = "output"
}

build {
  sources = ["sources.vmware-iso.ubuntu-noble"]

  provisioner "shell" {
    scripts = [
      "add-key.sh",
      "vmware-cleanup.sh"
    ]
  }
}