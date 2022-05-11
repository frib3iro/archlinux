#!/usr/bin/env bash
# --------------------------------------------------------
# Script    : [install-01.sh]
# Descrição : Script para instalação do arch linux no modo UEFI
# Versão    : 1.0
# Autor     : Fabio Junior Ribeiro
# Email     : rib3iro@live.com
# Data      : 11/12/2020
# Licença   : GNU/GPL v3.0
# --------------------------------------------------------
# Uso       : ./install-01.sh
# --------------------------------------------------------

source variaveis.sh
clear

# --------------------------------------------------------

# Tela de boas vindas
echo -e "${s} ${b}Bem vindo a primeira parte da instalação do ArchLinux UEFI/GPT...${f}"
sleep 2s

# Definir o idioma do ambiente live
echo
echo -e "${s} ${b}Definir o idioma do ambiente live...${f}"
sleep 2s
sed -i 's/#pt_BR.UTF-8/pt_BR.UTF-8/' /etc/locale.gen
locale-gen
export LANG=pt_BR.UTF-8

# Atualizar o relógio do sistema
echo
echo -e "${s} ${b}Atualizar o relógio do sistema...${f}"
sleep 2s
timedatectl set-ntp true

# Listando os discos
echo
echo -e "${s} ${b}Listando os discos...${f}"
sleep 2s
lsblk -l | grep disk

# Informando o nome do seu disco
echo
echo -en "${s} ${y}Informe o nome do seu disco: ${f}"
read -e disco
disco=/dev/${disco}

echo
echo -e "${s} ${b}Iniciando particionamento do disco...${f}"
sleep 2s
fdisk ${disco}

# Formatando partições
echo
echo -e "${s} ${b}Formatando as partições...${f}"
sleep 2s
mkfs.fat -F32 ${disco}1
mkfs.ext4 ${disco}2

# Montando partições
echo
echo -e "${s} ${b}Montando as partições...${f}"
sleep 2s
mount ${disco}2 /mnt
mkdir -p /mnt/boot/efi
mount ${disco}1 /mnt/boot/efi

# Listando partições
echo
echo -e "${s} ${b}Conferindo as partições...${f}"
lsblk ${disco}
echo -e "${s} ${y}Aperte enter para continuar...${f}"
read

# Instalando os pacotes base
echo
echo -e "${s} ${b}Instalando os pacotes base...${f}"
sleep 2s
pacstrap /mnt base base-devel linux linux-firmware intel-ucode

# Gerando o arquivo fstab
echo
echo -e "${s} ${b}Gerando o arquivo fstab...${f}"
sleep 2s
genfstab -U /mnt >> /mnt/etc/fstab

# Copiando o script archinstall-02.sh para /mnt
echo
echo -e "${s} ${b}Copiando os scripts de instalação para /mnt...${f}"
sleep 2s
mv *.sh /mnt

# Iniciando arch-chroot
echo
echo -e "${s} ${b}Iniciando arch-chroot...${f}"
sleep 2s
arch-chroot /mnt ./install-02.sh

