#cloud-config
autoinstall:
  version: 1
  early-commands:
    - sudo systemctl stop ssh
  locale: ${vm_guest_os_language}
  keyboard:
    layout: ${vm_guest_os_keyboard}
  ssh:
    install-server: true
    allow-pw: true
  packages:
    - openssh-server
    - open-vm-tools
    - cloud-init
    - wget
  user-data:
    disable_root: false
    timezone: ${vm_guest_os_timezone}
  late-commands:
    - sed -i -e 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /target/etc/ssh/sshd_config
    - sed -i -e 's/^UseDNS yes/UseDNS no/' /target/etc/ssh/sshd_config
    - echo 'vagrant ALL=(ALL) NOPASSWD:ALL' > /target/etc/sudoers.d/vagrant
    - curtin in-target --target=/target -- chmod 440 /etc/sudoers.d/vagrant
    - curtin in-target --target=/target -- mkdir -pv /home/vagrant/.ssh
    - curtin in-target --target=/target -- chmod 700 /home/vagrant/.ssh
    - curtin in-target --target=/target -- wget -O /home/vagrant/.ssh/authorized_keys https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant.pub
    - curtin in-target --target=/target -- chmod 644 /home/vagrant/.ssh/authorized_keys
    - curtin in-target --target=/target -- dd if=/dev/zero of=/EMPTY bs=1M || true
    - curtin in-target --target=/target -- rm -f /EMPTY
    - curtin in-target --target=/target -- sync
    - curtin in-target --target=/target -- vmware-toolbox-cmd disk shrink /
  identity:
    hostname: ubuntu-server-2204
    password: "$1$r2NloNBC$kSbIBH09KfzNU9PXtH3.D."
    username: vagrant
