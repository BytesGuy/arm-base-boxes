# Kickstart file for CentOS 9 Stream
text --non-interactive
eula --agreed

# Configure language
lang ${vm_guest_os_language}

# Configure keyboard
keyboard ${vm_guest_os_keyboard}

# Configure timezone
timezone ${vm_guest_os_timezone}

# Configure install source
url --url=${vm_guest_os_install_url}

# Configure repo for CentOS 9 Stream
repo --name=centos9-AppStream --baseurl=${vm_guest_os_repo_url}

# Configure packages to be installed
%packages
@^minimal-environment
open-vm-tools
%end

# Run the setup agent on first boot
firstboot --enable

# Configure disk and paritioning
ignoredisk --only-use=nvme0n1
autopart

# Partition clearing information
clearpart --none --initlabel

# Root password and user configuration
rootpw --plaintext vagrant
user --groups=wheel --name=vagrant --password=vagrant --plaintext --uid=1000 --gid=1000 --gecos="vagrant"

# Post configuration
%post
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant
%end
