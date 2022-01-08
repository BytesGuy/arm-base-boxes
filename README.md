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
