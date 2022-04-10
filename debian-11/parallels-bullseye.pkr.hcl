source "parallels-iso" "debian-bullseye" {
  iso_url = "https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-11.3.0-arm64-netinst.iso"
  iso_checksum = "md5:1fb24715f545447aff432e543436e57d"
  ssh_username = "vagrant"
  ssh_password = "vagrant"
  ssh_timeout = "30m"
  shutdown_command = "sudo shutdown -h now"
  guest_os_type = "debian"
  http_directory = "http"
  boot_command = [
        "c",
        "linux /install.a64/vmlinuz auto=true priority=critical url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg --- quiet",
        "<enter>",
        "initrd /install.a64/initrd.gz",
        "<enter>",
        "boot",
        "<enter><wait>"
  ]
  memory = 2048
  cpus = 2
  disk_size = 40000
  vm_name = "Debian 11"
  output_directory = "output"
  parallels_tools_flavor = "lin"
}

build {
  sources = ["sources.parallels-iso.debian-bullseye"]

  provisioner "shell" {
    scripts = [
      "add-key.sh",
      "parallels-cleanup.sh"
    ]
  }
}

packer {
  required_plugins {
    parallels = {
      version = ">= 1.0.1"
      source  = "github.com/hashicorp/parallels"
    }
  }
}