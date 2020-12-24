#!/usr/bin/env bash

# variaveis 
R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
C='\033[0;36m'
F='\033[0m'
S='\e[32;1m>>>\e[m'

# Para a maquina_virtual
MaquinaVirtual(){
    (echo g; echo n; echo ""; echo ""; echo +512M; echo t; echo 1; echo n; echo ""; echo ""; echo ""; echo w) | fdisk ${disco}
}

# Para a máquina real 
MaquinaReal(){
    (echo d; echo ""; echo d; echo ""; echo g; echo n; echo ""; echo ""; echo +512M; echo t; echo 1; echo n; echo ""; echo ""; echo ""; echo w) | fdisk ${disco}
}

# Tela de boas vindas
clear
echo -e "${S} ${C}Bem vindo a primeira parte da instalação do Arch Linux no modo UEFI${F}"
sleep 2
clear

# Atualizando o relógio do sistema
echo -e "${S} ${C}Atualizando o relógio do sistema${F}"
sleep 2
timedatectl set-ntp true
clear

# Listando os discos
echo -e "${S} ${C}Listando os discos${F}"
sleep 2
lsblk -l | grep disk

# Informando o nome do seu disco
echo -en "\n${S} ${C}Informe o nome do seu disco:${F} "
read disco
disco=/dev/${disco}
clear

echo -e "${S} ${C}Digite${F} ${R}[ 1 ]${F} ${C}para máquina virtual${F}"
echo -e "${S} ${C}Digite${F} ${R}[ 2 ]${F} ${C}para máquina real${F}"
echo -en "\n${S} ${Y}Digite sua resposta:${F} "
read resposta
clear

if [ "$resposta" -eq 1 ]; then
    echo -e "${S} ${C}Iniciando particionamento na máquina virtual${F}"
    sleep 2
    MaquinaVirtual
    clear
elif [ "$resposta" -eq 2 ]; then
    echo -e "${S} ${C}Iniciando particionamento na máquina real${F}"
    sleep 2
    MaquinaReal
    clear
else
    echo -e "${S} ${R}Resposta inválida!${F}"
    exit 1
fi

# Formatando partições
echo -e "${S} ${C}Formatando as partições${F}"
sleep 2
mkfs.fat -F32 ${disco}1
mkfs.ext4 ${disco}2
clear

# Montando partições
echo -e "${S} ${C}Montando as partições${F}"
sleep 2
mount ${disco}2 /mnt
mkdir -p /mnt/boot/efi
mount ${disco}1 /mnt/boot/efi
clear

# Listando partições
echo -e "${S} ${C}Conferindo as partições${F}"
lsblk ${disco}
sleep 3
clear

# Instalando os pacotes base
echo -e "${S} ${C}Instalando os pacotes base${F}"
sleep 2
pacstrap /mnt base base-devel linux linux-firmware vim intel-ucode
clear

# Gerando o fstab
echo -e "${S} ${C}Gerando o fstab${F}"
sleep 2
genfstab -U /mnt >> /mnt/etc/fstab
clear

# Copiando o script archinstall-02.sh para /mnt
echo -e "${S} ${C}Copiando o script install-02.sh para /mnt${F}"
sleep 2
cp install-02.sh /mnt
clear

# Iniciando arch-chroot
echo -e "${S} ${C}Iniciando arch-chroot${F}"
sleep 2
arch-chroot /mnt ./install-02.sh

