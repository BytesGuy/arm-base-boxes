packer {
  required_plugins {
    vmware = {
      version = ">= 1.0.5"
      source  = "github.com/hashicorp/vmware"
    }
  }
}

source "vmware-iso" "ubuntu-impish" {
  iso_url = "https://cdimage.ubuntu.com/releases/21.10/release/ubuntu-21.10-live-server-arm64.iso"
  iso_checksum = "md5:5420a741f41927ce9ddac768b69181c7"
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
  vm_name = "Ubuntu Server 21.10"
}

build {
  sources = ["sources.vmware-iso.ubuntu-impish"]

  provisioner "shell" {
    script = "vmware-cleanup.sh"
  }

  provisioner "shell-local" {
    inline = [
      "cp ../metadata.json .",
      "tar cvzf vmware-impish-arm64.box ./*",
      "md5 vmware-impish-arm64.box",
      "rm -f *.v* *.nvram metadata.json"
    ]
  }
}