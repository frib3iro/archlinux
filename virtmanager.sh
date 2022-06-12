#!/usr/bin/env bash
#-----------------------------------------------------------------------
# Script    : [virtmanager.sh]
# Descrição :
# Versão    : 1.0
# Autor     : Fabio Junior Ribeiro 
# Email     : rib3iro@live.com
# Github    : https://github.com/frib3iro 
# Data      : 28/05/2022
# Licença   : GNU/GPL v3.0
#-----------------------------------------------------------------------
# Uso       :
#-----------------------------------------------------------------------
# Step 1: Install KVM packages

# First step is installing all packages needed to run KVM:

sudo pacman -Syu
sudo pacman -S bridge-utils dmidecode dnsmasq edk2-ovmf iptables-nft libguestfs libvirt openbsd-netcat qemu-desktop vde2 virt-manager virt-viewer
sleep 2s

# Step 3: Start KVM libvirt service

# Once the installation is done, start and enable libvirtd service to start at boot:

sudo systemctl enable libvirtd.service
sleep 2s
sudo systemctl start libvirtd.service
sleep 2s
#sudo systemctl status libvirtd.service

# Add your user account to libvirt group.
sudo usermod -a -G libvirt $(whoami)
sleep 2s

# Restart libvirt daemon.
sudo systemctl restart libvirtd.service
sleep 2s

# Open the file /etc/libvirt/libvirtd.conf for editing.

# Set the UNIX domain socket group ownership to libvirt, (around line 85)
sudo sed -i 's/# unix_sock_group = "libvirt"/unix_sock_group = "libvirt"/' /etc/libvirt/libvirtd.conf
sleep 2s

# Set the UNIX socket permissions for the R/W socket (around line 102)
sudo sed -i 's/# unix_sock_rw_perms = "0770"/unix_sock_rw_perms = "0770"/' /etc/libvirt/libvirtd.conf
sleep 2s

# Set the UNIX socket permissions for the R/W socket (around line 102)
sudo sed -i 's/#       user = "qemu"/user = "fabio"/' /etc/libvirt/qemu.conf
sleep 2s

# Set the UNIX socket permissions for the R/W socket (around line 102)
sudo sed -i 's/#group = "libvirt-qemu"/group = "fabio"/' /etc/libvirt/qemu.conf
sleep 2s


