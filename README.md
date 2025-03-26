# arm-base-boxes
Vagrant Base Boxes for ARM Hosts (e.g., Apple Silicon)

This repository provides the Packer files for building Vagrant base boxes for ARM hosts.

The pre-built boxes can be found on [Vagrant Cloud](https://portal.cloud.hashicorp.com/vagrant/discover/bytesguy)

🚨 These should not be used for production workloads - use them at your own risk! 🚨

## Currently Supported Boxes

| Distro | Version | Provider | Source | Box |
| ------ | ------- | -------- | ------ | --- |
| Ubuntu Server | 24.04 (Noble Numbat) | VMware Fusion | [Source](ubuntu-server-24.04) | [bytesguy/ubuntu-server-24.04-arm64](https://portal.cloud.hashicorp.com/vagrant/discover/bytesguy/ubuntu-server-24.04-arm64) |
| Ubuntu Server | 22.04 (Jammy Jellyfish) | VMware Fusion | [Source](ubuntu-server-22.04/) | [bytesguy/ubuntu-server-22.04-arm64](https://app.vagrantup.com/bytesguy/boxes/ubuntu-server-22.04-arm64) |
| Ubuntu Server | 20.04 (Focal Fossa) | VMware Fusion, Parallels | [Source](ubuntu-server-20.04/) | [bytesguy/ubuntu-server-20.04-arm64](https://app.vagrantup.com/bytesguy/boxes/ubuntu-server-20.04-arm64) |
| Debian | 11 (Bullseye) | VMware Fusion, Parallels | [Source](debian-11/) | [bytesguy/debian-11-arm64](https://app.vagrantup.com/bytesguy/boxes/debian-11-arm64) |

## Historical / End-of-Life Boxes

| Distro | Version | Provider | Box |
| ------ | ------- | -------- | --- |
| Ubuntu Server | 21.10 (Impish Indri) | VMware Fusion | [bytesguy/ubuntu-server-21.10-arm64](https://app.vagrantup.com/bytesguy/boxes/ubuntu-server-21.10-arm64) |
| Debian | 10 (Buster) | VMware Fusion | [bytesguy/debian-10-arm64](https://app.vagrantup.com/bytesguy/boxes/debian-10-arm64) |

## Usage Instructions

To build, enter the directory for the box you wish to build, then:

1. Run `packer init` to install Packer plugins
1. Run `packer build <box name>>.pkr.hcl`

The box file will be created in the `output` directory once the build has completed
