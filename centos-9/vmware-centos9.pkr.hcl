packer {
  required_plugins {
    vmware = {
      version = ">= 1.0.5"
      source  = "github.com/hashicorp/vmware"
    }
  }
}

source "vmware-iso" "centos-9" {
  iso_url = "http://mirror.stream.centos.org/9-stream/BaseOS/aarch64/iso/CentOS-Stream-9-latest-aarch64-boot.iso"
  # As Stream is updated daily we skip the checksum by default
  # buildbox script can pull the latest checksum for verfication if required
  iso_checksum = "none"
  # We don't want to cache as the image gets updated often
  cleanup_remote_cache = true
  ssh_username = "vagrant"
  ssh_password = "vagrant"
  ssh_timeout = "30m"
  shutdown_command = "sudo shutdown -h now"
  guest_os_type = "arm-fedora-64"
  disk_adapter_type = "nvme"
  version = 19
  http_directory = "http"
  boot_command = [
        "c",
        "linux /images/pxeboot/vmlinuz inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg",
        "<enter>",
        "initrd /images/pxeboot/initrd.img",
        "<enter>",
        "boot",
        "<enter><wait>"
  ]
  usb = true
  memory = 2048
  cpus = 2
  disk_size = 40000
  vm_name = "Centos 9 Stream"
  output_directory = "output"
}

build {
  sources = ["sources.vmware-iso.centos-9"]

  provisioner "shell" {
    scripts = [
      "add-key.sh",
      "vmware-cleanup.sh"
    ]
  }
}