#!/bin/bash

mkdir /home/vagrant/.ssh
chmod 0700 /home/vagrant/.ssh
wget -O /home/vagrant/.ssh/authorized_keys https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant.pub
chmod 0600 /home/vagrant/.ssh/authorized_keys