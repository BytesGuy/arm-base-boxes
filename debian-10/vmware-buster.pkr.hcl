packer {
  required_plugins {
    vmware = {
      version = ">= 1.0.5"
      source  = "github.com/hashicorp/vmware"
    }
  }
}

source "vmware-iso" "debian-buster" {
  iso_url = "https://cdimage.debian.org/cdimage/archive/10.11.0/arm64/iso-cd/debian-10.11.0-arm64-netinst.iso"
  iso_checksum = "md5:6dc8ea84db6cc9c36c34045891f12f5b"
  ssh_username = "vagrant"
  ssh_password = "vagrant"
  ssh_timeout = "30m"
  shutdown_command = "sudo shutdown -h now"
  guest_os_type = "arm-debian10-64"
  disk_adapter_type = "nvme"
  version = 19
  http_directory = "http"
  boot_command = [
        "c",
        "linux /install.a64/vmlinuz auto=true priority=critical url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg --- quiet",
        "<enter>",
        "initrd /install.a64/initrd.gz",
        "<enter>",
        "boot",
        "<enter>"
  ]
  usb = true
  vmx_data = {
    "usb_xhci.present" = "true"
  }
  memory = 2048
  cpus = 2
  disk_size = 40000
  vm_name = "Debian 10"
  output_directory = "output"
}

build {
  sources = ["sources.vmware-iso.debian-buster"]

  provisioner "shell" {
    scripts = [
      "add-key.sh",
      "vmware-cleanup.sh"
    ]
  }
}