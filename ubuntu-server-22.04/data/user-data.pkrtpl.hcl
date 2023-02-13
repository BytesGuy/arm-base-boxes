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
    - mkdir -pv /home/vagrant/.ssh
    - chmod 0700 /home/vagrant/.ssh
    - wget -O /home/vagrant/.ssh/authorized_keys https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant.pub
    - chmod 0600 /home/vagrant/.ssh/authorized_keys
    - sudo dd if=/dev/zero of=/EMPTY bs=1M
    - sudo rm -f /EMPTY
    - sync
    - sudo vmware-toolbox-cmd disk shrink /
  identity:
    hostname: ubuntu-server-2204
    password: "$64n946x4NEoA"
    username: vagrant
