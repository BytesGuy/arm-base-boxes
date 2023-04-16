# arm-base-boxes

Vagrant base boxes for ARM hosts (e.g., Apple Silicon M1).

This repository contains Packer files for building Vagrant base boxes for ARM hosts.

🚨 These Vagrant boxes should not be used for production workloads - use them at your own risk! 🚨

## Supported Boxes

| Distro          | Version | Provider      | Source                        |
| --------------- | ------- | ------------- | ----------------------------- |
| CentOS Stream   | 9       | VMware Fusion | [Source](centos-9)            |
| Ubuntu Server   | 22.04.2 | VMware Fusion | [Source](ubuntu-server-22.04) |
| Debian          | 11      | VMware Fusion | [Source](debian-11)           |

## Dependencies

- [Packer](https://www.packer.io/):

    ```bash
    brew install packer
    ```

- [Vagrant](https://www.vagrantup.com/):

    ```bash
    # You may need to install rosetta first
    # sudo softwareupdate --install-rosetta
    brew install --cask vagrant
    ```

- [VMware Fusion](https://www.vmware.com/products/fusion.html)
- [Vagrant VMware Utility](https://formulae.brew.sh/cask/vagrant-vmware-utility):

    ```bash
    brew install --cask vagrant-vmware-utility
    ```

- [Vagrant VMware provider plugin](https://developer.hashicorp.com/vagrant/docs/providers/vmware/installation):

    ```bash
    vagrant plugin install vagrant-vmware-desktop
    ```

## Usage

1. Use the `buildbox.sh` script in each directory to build the box and add it to Vagrant:

   ```bash
   chmod +x ./buildbox.sh && ./buildbox.sh
   ```

2. Start the VM with Vagrant:

   ```bash
   vagrant up
   ```

Enjoy! ✨🚀
