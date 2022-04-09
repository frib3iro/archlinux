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

# --------------------------------------------------------

clear

# Tela de boas vindas
echo -e "${S} ${C}Bem vindo a primeira parte da instalação do ArchLinux UEFI/GPT${F}"
sleep 2s

# Definir a fonte do ambiente live
echo
echo -e "${S} ${C}Definir a fonte do ambiente live${F}"
sleep 2s
setfont ter-120n

# Definir o idioma do ambiente live
echo
echo -e "${S} ${C}Definir o idioma do ambiente live${F}"
sleep 2s
sed -i 's/#pt_BR.UTF-8/pt_BR.UTF-8/' /etc/locale.gen
locale-gen
export LANG=pt_BR.UTF-8

# Atualizar o relógio do sistema
echo
echo -e "${S} ${C}Atualizar o relógio do sistema${F}"
sleep 2s
timedatectl set-ntp true

# Listando os discos
echo
echo -e "${S} ${C}Listando os discos${F}"
sleep 2s
lsblk -l | grep disk

# Informando o nome do seu disco
echo
echo -en "${S} ${Y}Informe o nome do seu disco:${F} "
sleep 2s
read disco
disco=/dev/${disco}

echo
echo -e "${S} ${C}Iniciando particionamento do disco${F}"
sleep 2s
(echo d; echo ""; echo d; echo ""; echo g; echo n; echo ""; echo ""; echo +512M; echo t; echo 1; echo n; echo ""; echo ""; echo ""; echo w) | fdisk ${disco}

# Formatando partições
echo
echo -e "${S} ${C}Formatando as partições${F}"
sleep 2s
mkfs.fat -F32 ${disco}1
mkfs.ext4 ${disco}2

# Montando partições
echo
echo -e "${S} ${C}Montando as partições${F}"
sleep 2s
mount ${disco}2 /mnt
mkdir -p /mnt/boot/efi
mount ${disco}1 /mnt/boot/efi

# Listando partições
echo
echo -e "${S} ${C}Conferindo as partições${F}"
sleep 2s
lsblk ${disco}
echo -e "${S} ${Y}Aperte enter para continuar${F}"
read

# Instalando os pacotes base
echo
echo -e "${S} ${C}Instalando os pacotes base${F}"
sleep 2s
pacstrap /mnt base base-devel linux linux-firmware intel-ucode

# Gerando o arquivo fstab
echo
echo -e "${S} ${C}Gerando o arquivo fstab${F}"
sleep 2s
genfstab -U /mnt >> /mnt/etc/fstab

# Copiando o script archinstall-02.sh para /mnt
echo
echo -e "${S} ${C}Copiando os de instalação scripts para /mnt${F}"
sleep 2s
mv *.sh /mnt

# Iniciando arch-chroot
echo
echo -e "${S} ${C}Iniciando arch-chroot${F}"
sleep 2s
arch-chroot /mnt ./install-02.sh

