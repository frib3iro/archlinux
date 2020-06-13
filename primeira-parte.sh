#!/usr/bin/env bash

# variaveis
pass_user='cp1113bug6u'
mirror='/etc/pacman.d/mirrorlist'
blue='\e[34;1m'
green='\e[32;1m'
red='\e[31;1m'
yellow='\e[33;1m'
end='\e[m'
seta='\e[32;1m==>\e[m'

# Funções ---------------------------------------------
# Para a maquina maquina_virtual
maquina_virtual(){
    (echo g; echo n; echo ""; echo ""; echo +512M; echo t; echo 1; echo n; echo ""; echo ""; echo ""; echo w) | fdisk ${disco}
}

# Para a maquina real 
maquina_real(){
    (echo d; echo ""; echo d; echo ""; echo g; echo n; echo ""; echo ""; echo +512M; echo t; echo 1; echo n; echo ""; echo ""; echo ""; echo w) | fdisk ${disco}
}

# Tela de boas vindas
clear
echo -e "${seta} ${blue}Bem vindo a instalação do Arch Linux${end}"
sleep 2s
clear

# Definindo layout do teclado
echo -e "${seta} ${blue}Definindo o layout do teclado${end}"
sleep 2s
loadkeys br-abnt2
clear

# Atualizando o relógio do sistema
echo -e "${seta} ${blue}Atualizando o relógio do sistema${end}"
sleep 2s
timedatectl set-ntp true
clear

# Listando os discos
echo -e "${seta} ${blue}Listando os discos${end}"
sleep 2s
lsblk -l | grep disk

# Informando o nome do seu disco
echo -en "\n${seta} ${blue}Informe o nome do seu disco:${end} "
read disco
disco=/dev/${disco}
clear

echo -e "${seta} ${blue}Digite${end} ${red}[ 1 ]${end} ${blue}para maquina maquina virtual${end}${end}"
echo -e "${seta} ${blue}Digite${end} ${red}[ 2 ]${end} ${blue}para maquina maquina real${end}"
echo -en "\n${seta} ${yellow}Digite sua resposta:${end} "
read resposta
clear

if [ "$resposta" -eq 1 ]; then
    echo -e "${seta} ${blue}Iniciando particionamento na maquina virtual${end}"
    sleep 2s
    maquina_virtual
    clear
elif [ "$resposta" -eq 2 ]; then
    echo -e "${seta} ${blue}Iniciando particionamento na maquina real${end}"
    sleep 2s
    maquina_real
    clear
else
    echo -e "${seta} ${red}Resposta inválida!${end}"
    exit 1
fi

# Formatando partições
echo -e "${seta} ${blue}Formatando as partições${end}"
sleep 2s
mkfs.fat -F32 ${disco}1
mkfs.ext4 ${disco}2
clear

# Montando partições
echo -e "${seta} ${blue}Montando as partições${end}"
sleep 2s
mount ${disco}2 /mnt
mkdir -p /mnt/boot
mount ${disco}1 /mnt/boot
clear

# Listando partições
echo -e "${seta} ${blue}Conferindo as partições${end}"
lsblk ${disco}
sleep 3s
clear

# Configurando mirrorlist
echo -e "${seta} ${blue}Fazendo backup do mirrorlist${end}"
sleep 2s
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
clear

echo -e "${seta} ${blue}Comentando todos os servidores${end}"
sleep 2s
sed 's/^Ser/#Ser/' ${mirror} > ${mirror}.bkp
clear

echo -e "${seta} ${blue}Descomentando os servidores Brasileiros${end}"
sleep 2s
sed '/Brazil/{n;s/^#//}' ${mirror}.bkp > ${mirror}
clear

# Atualizando os repositórios
echo -e "${seta} ${blue}Atualizando os repositórios${end}"
sleep 2s
pacman -Syyy --noconfirm
clear

# Instalando os pacotes base
echo -e "${seta} ${blue}Instalando os pacotes base${end}"
sleep 2s
pacstrap /mnt base base-devel linux linux-firmware
clear

# Gerando o fstab
echo -e "${seta} ${blue}Gerando o fstab${end}"
sleep 2s
genfstab -U /mnt >> /mnt/etc/fstab
clear

# Copiando o script archinstall-02.sh para /mnt
echo -e "${seta} ${blue}Copiando o script archinstall-02.sh para /mnt${end}"
sleep 2s
cp segunda-parte.sh /mnt
clear

# Iniciando arch-chroot
echo -e "${seta} ${blue}Iniciando arch-chroot${end}"
sleep 2s
arch-chroot /mnt ./segunda-parte.sh

