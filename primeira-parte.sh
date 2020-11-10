#!/usr/bin/env bash

# variaveis e password root/user
mirror='/etc/pacman.d/mirrorlist'
ciano='\033[0;36m'
verde='\033[0;32m'
vermelho='\033[0;31m'
amarelo='\033[0;32m'
fim='\033[0m'
seta='\e[32;1m-->\e[m'

# Funções ---------------------------------------------

# Para a maquina_virtual
virtual(){
    (echo g; echo n; echo ""; echo ""; echo +512M; echo t; echo 1; echo n; echo ""; echo ""; echo ""; echo w) | fdisk ${disco}
}

# Para a máquina real 
real(){
    (echo d; echo ""; echo d; echo ""; echo g; echo n; echo ""; echo ""; echo +512M; echo t; echo 1; echo n; echo ""; echo ""; echo ""; echo w) | fdisk ${disco}
}

# Tela de boas vindas
clear
echo -e "${seta} ${ciano}Bem vindo a instalação do Arch Linux${fim}"
sleep 2s
clear

# Definindo layout do teclado
echo -e "${seta} ${ciano}Definindo o layout do teclado${fim}"
sleep 2s
loadkeys br-abnt2
clear

# Atualizando o relógio do sistema
echo -e "${seta} ${ciano}Atualizando o relógio do sistema${fim}"
sleep 2s
timedatectl set-ntp true
clear

# Listando os discos
echo -e "${seta} ${ciano}Listando os discos${fim}"
sleep 2s
lsblk -l | grep disk

# Informando o nome do seu disco
echo -en "\n${seta} ${ciano}Informe o nome do seu disco:${fim} "
read disco
disco=/dev/${disco}
clear

echo -e "${seta} ${ciano}Digite${fim} ${vermelho}[ 1 ]${fim} ${ciano}para máquina virtual${fim}${fim}"
echo -e "${seta} ${ciano}Digite${fim} ${vermelho}[ 2 ]${fim} ${ciano}para máquina real${fim}"
echo -en "\n${seta} ${amarelo}Digite sua resposta:${fim} "
read resposta
clear

if [ "$resposta" -eq 1 ]; then
    echo -e "${seta} ${ciano}Iniciando particionamento na máquina virtual${fim}"
    sleep 2s
    virtual
    clear
elif [ "$resposta" -eq 2 ]; then
    echo -e "${seta} ${ciano}Iniciando particionamento na máquina real${fim}"
    sleep 2s
    real
    clear
else
    echo -e "${seta} ${vermelho}Resposta inválida!${fim}"
    exit 1
fi

# Formatando partições
echo -e "${seta} ${ciano}Formatando as partições${fim}"
sleep 2s
mkfs.fat -F32 ${disco}1
mkfs.ext4 ${disco}2
clear

# Montando partições
echo -e "${seta} ${ciano}Montando as partições${fim}"
sleep 2s
mount ${disco}2 /mnt
mkdir -p /mnt/boot/efi
mount ${disco}1 /mnt/boot/efi
clear

# Listando partições
echo -e "${seta} ${ciano}Conferindo as partições${fim}"
lsblk ${disco}
sleep 3s
clear

# Instalando os pacotes base
echo -e "${seta} ${ciano}Instalando os pacotes base${fim}"
sleep 2s
pacstrap /mnt base base-devel linux linux-firmware vim wget intel-ucode
clear

# Gerando o fstab
echo -e "${seta} ${ciano}Gerando o fstab${fim}"
sleep 2s
genfstab -U /mnt >> /mnt/etc/fstab
clear

# Copiando o script archinstall-02.sh para /mnt
echo -e "${seta} ${ciano}Copiando o script archinstall-02.sh para /mnt${fim}"
sleep 2s
cp segunda-parte.sh /mnt
clear

# Iniciando arch-chroot
echo -e "${seta} ${ciano}Iniciando arch-chroot${fim}"
sleep 2s
arch-chroot /mnt ./segunda-parte.sh

