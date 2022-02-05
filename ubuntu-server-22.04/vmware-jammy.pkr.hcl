packer {
  required_plugins {
    vmware = {
      version = ">= 1.0.5"
      source  = "github.com/hashicorp/vmware"
    }
  }
}

source "vmware-iso" "ubuntu-jammy" {
  iso_url = "https://cdimage.ubuntu.com/releases/22.04/release/ubuntu-22.04-live-server-arm64.iso"
  iso_checksum = "md5:TBC"
  ssh_username = "vagrant"
  ssh_password = "vagrant"
  ssh_timeout = "30m"
  shutdown_command = "sudo shutdown -h now"
  guest_os_type = "arm-ubuntu-64"
  disk_adapter_type = "nvme"
  version = 19
  http_directory = "http"
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
  vm_name = "Ubuntu Server 22.04"
  output_directory = "output"
}

build {
  sources = ["sources.vmware-iso.ubuntu-jammy"]

  provisioner "shell" {
    scripts = [
      "add-key.sh",
      "vmware-cleanup.sh"
    ]
  }
}