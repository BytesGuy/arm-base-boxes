# arm-base-boxes
Vagrant Base Boxes for ARM Hosts (e.g., Apple Silicon / M1)

This repository provides the Packer files for building Vagrant base boxes for ARM hosts.

The pre-built boxes can be found on [Vagrant Cloud](https://app.vagrantup.com/bytesguy)

🚨 These should not be used for production workloads - use them at your own risk! 🚨

## Currently Supported Boxes

| Distro | Version | Provider | Source | Box |
| ------ | ------- | -------- | ------ | --- |
| Ubuntu Server | 20.04.3 (Focal Fossa) | VMWare Fusion | [Source](ubuntu-server-20.04/) | [bytesguy/ubuntu-server-20.04-arm64](https://app.vagrantup.com/bytesguy/boxes/ubuntu-server-20.04-arm64) |
| Ubuntu Server | 21.10 (Impish Indri) | VMWare Fusion | [Source](ubuntu-server-21.10/) | [bytesguy/ubuntu-server-21.10-arm64](https://app.vagrantup.com/bytesguy/boxes/ubuntu-server-21.10-arm64) |
| Debian | 11.2 (Bullseye) | VMWare Fusion | [Source](debian-11/) | [bytesguy/debian-11-arm64](https://app.vagrantup.com/bytesguy/boxes/debian-11-arm64) |

## In-Progress / Planned

| Distro | Version | Provider | Source |
| ------ | ------- | -------- | ------ |
| Centos | 9 Stream | VMWare Fusion | |

## Usage Instructions

TODO

## Building Instructions

The VM images are built with Packer and VMWare Fusion. Each subdirectory in this repo contains all the files needed to build the base box. The easiest way of building the box is to run the `buildbox.sh` command. This will start Packer and build the image, then compact the image into a box and print the checksum.