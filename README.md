# arm-base-boxes

Vagrant base boxes for ARM hosts (e.g., Apple Silicon M1).

This repository provides packer files for building Vagrant base boxes for ARM hosts.

🚨 These should not be used for production workloads - use them at your own risk! 🚨

## Supported Boxes

| Distro          | Version | Provider      | Source             |
| --------------- | ------- | ------------- | ------------------ |
| CentOS 9 Stream | 9       | VMWare Fusion | [Source](centos-9) |

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

- [VMWare Fusion](https://www.vmware.com/products/fusion.html)
- [Vagrant VMWare Utility](https://formulae.brew.sh/cask/vagrant-vmware-utility):

    ```bash
    brew install --cask vagrant-vmware-utility
    ```

- [Vagrant VMware provider plugin](https://developer.hashicorp.com/vagrant/docs/providers/vmware/installation):

    ```bash
    vagrant plugin install vagrant-vmware-desktop
    ```

## Usage

Use the `buildbox.sh` script in each directory to build the box and add it to Vagrant:

```bash
./buildbox.sh
```
