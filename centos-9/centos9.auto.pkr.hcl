// centos9 packer variables file

variable "vm_guest_os_language" {
  type        = string
  description = "Guest OS language"
  default     = "en_GB"
}

variable "vm_guest_os_keyboard" {
  type        = string
  description = "Guest OS keyboard"
  default     = "gb"
}

variable "vm_guest_os_timezone" {
  type        = string
  description = "Guest OS timezone"
  default     = "Europe/London"
}

variable "vm_guest_os_install_url" {
  type        = string
  description = "Guest OS install URL"
  default     = "https://mirror.stream.centos.org/9-stream/BaseOS/aarch64/os/"
}

variable "vm_guest_os_repo_url" {
  type        = string
  description = "Guest OS repo URL"
  default     = "https://mirror.stream.centos.org/9-stream/AppStream/aarch64/os/"
}

// https://developer.hashicorp.com/packer/plugins/builders/vmware/iso#disk_size
variable "disk_size" {
  type        = number
  description = "Size of the disk in MB"
  // ~40GB
  default = 40000
}

// https://developer.hashicorp.com/packer/plugins/builders/vmware/iso#guest_os_type
variable "guest_os_type" {
  type        = string
  description = "Guest OS type"
  default     = "arm-fedora-64"
}

// https://developer.hashicorp.com/packer/plugins/builders/vmware/iso#version
variable "vmx_hardware_version" {
  type        = number
  description = "VMX hardware version"
  default     = 20
}

// https://developer.hashicorp.com/packer/plugins/builders/vmware/iso#vm_name
variable "vm_name" {
  type        = string
  description = "VM name"
  default     = "centos9"
}

// https://developer.hashicorp.com/packer/plugins/builders/vmware/iso#extra-disk-configuration
variable "disk_adapter_type" {
  type        = string
  description = "Disk adapter type"
  default     = "nvme"
}

// https://developer.hashicorp.com/packer/plugins/builders/vmware/iso#extra-disk-configuration
variable "disk_type_id" {
  type        = string
  description = "Disk type ID"
  default     = "1"
}

// https://developer.hashicorp.com/packer/plugins/builders/vmware/iso#iso-configuration
variable "iso_checksum" {
  type        = string
  description = "ISO checksum"
  default     = "file:https://mirror.stream.centos.org/9-stream/BaseOS/aarch64/iso/CentOS-Stream-9-latest-aarch64-boot.iso.SHA256SUM"
}

variable "iso_url" {
  type    = string
  default = "https://mirror.stream.centos.org/9-stream/BaseOS/aarch64/iso/CentOS-Stream-9-latest-aarch64-boot.iso"
}

// https://developer.hashicorp.com/packer/plugins/builders/vmware/iso#hardware-configuration
variable "cpus" {
  type        = number
  description = "Number of CPUs"
  default     = 2
}

variable "memory" {
  type        = number
  description = "Memory in MB"
  default     = 2048
}

// https://developer.hashicorp.com/packer/plugins/builders/vmware/iso#optional-ssh-fields
variable "ssh_timeout" {
  type        = string
  description = "SSH timeout"
  default     = "30m"
}
