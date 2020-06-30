#!/usr/bin/env bash

# variaveis
mirror='/etc/pacman.d/mirrorlist'
azul='\e[34;1m'
verde='\e[32;1m'
vermelho='\e[31;1m'
amarelo='\e[33;1m'
fim='\e[m'
seta='\e[32;1m==>\e[m'

# Funções ---------------------------------------------
# Para a maquina_virtual
maquina_virtual(){
    (echo g; echo n; echo ""; echo ""; echo +512M; echo t; echo 1; echo n; echo ""; echo ""; echo ""; echo w) | fdisk ${disco}
}

# Para a máquina real 
maquina_real(){
    (echo d; echo ""; echo d; echo ""; echo g; echo n; echo ""; echo ""; echo +512M; echo t; echo 1; echo n; echo ""; echo ""; echo ""; echo w) | fdisk ${disco}
}

# Tela de boas vindas
clear
echo -e "${seta} ${azul}Bem vindo a instalação do Arch Linux${fim}"
sleep 2s
clear

# Definindo layout do teclado
echo -e "${seta} ${azul}Definindo o layout do teclado${fim}"
sleep 2s
loadkeys br-abnt2
clear

# Atualizando o relógio do sistema
echo -e "${seta} ${azul}Atualizando o relógio do sistema${fim}"
sleep 2s
timedatectl set-ntp true
clear

# Listando os discos
echo -e "${seta} ${azul}Listando os discos${fim}"
sleep 2s
lsblk -l | grep disk

# Informando o nome do seu disco
echo -en "\n${seta} ${azul}Informe o nome do seu disco:${fim} "
read disco
disco=/dev/${disco}
clear

echo -e "${seta} ${azul}Digite${fim} ${vermelho}[ 1 ]${fim} ${azul}para máquina virtual${fim}${fim}"
echo -e "${seta} ${azul}Digite${fim} ${vermelho}[ 2 ]${fim} ${azul}para máquina real${fim}"
echo -en "\n${seta} ${amarelo}Digite sua resposta:${fim} "
read resposta
clear

if [ "$resposta" -eq 1 ]; then
    echo -e "${seta} ${azul}Iniciando particionamento na máquina virtual${fim}"
    sleep 2s
    maquina_virtual
    clear
elif [ "$resposta" -eq 2 ]; then
    echo -e "${seta} ${azul}Iniciando particionamento na máquina real${fim}"
    sleep 2s
    maquina_real
    clear
else
    echo -e "${seta} ${vermelho}Resposta inválida!${fim}"
    exit 1
fi

# Formatando partições
echo -e "${seta} ${azul}Formatando as partições${fim}"
sleep 2s
mkfs.fat -F32 ${disco}1
mkfs.ext4 ${disco}2
clear

# Montando partições
echo -e "${seta} ${azul}Montando as partições${fim}"
sleep 2s
mount ${disco}2 /mnt
mkdir -p /mnt/boot/efi
mount ${disco}1 /mnt/boot/efi
clear

# Listando partições
echo -e "${seta} ${azul}Conferindo as partições${fim}"
lsblk ${disco}
sleep 3s
clear

# Configurando mirrorlist
echo -e "${seta} ${azul}Fazendo backup do mirrorlist${fim}"
sleep 2s
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
clear

# Instalando os pacotes base
echo -e "${seta} ${azul}Instalando os pacotes base${fim}"
sleep 2s
pacstrap /mnt base base-devel linux linux-firmware
clear

# Gerando o fstab
echo -e "${seta} ${azul}Gerando o fstab${fim}"
sleep 2s
genfstab -U /mnt >> /mnt/etc/fstab
clear

# Copiando o script archinstall-02.sh para /mnt
echo -e "${seta} ${azul}Copiando o script archinstall-02.sh para /mnt${fim}"
sleep 2s
cp segunda-parte.sh /mnt
clear

# Iniciando arch-chroot
echo -e "${seta} ${azul}Iniciando arch-chroot${fim}"
sleep 2s
arch-chroot /mnt ./segunda-parte.sh

clear
echo -e "${seta} ${azul}Iniciando a segunda parte da instalação${fim}"
sleep 2s
clear

# Criando o arquivo de swap
echo -e "${seta} ${azul}Criando o arquivo de swap${fim}"
sleep 2s
dd if=/dev/zero of=/swapfile bs=1M count=2048 status=progress
fallocate -l 2GB /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile none swap defaults 0 0" >> /etc/fstab
clear

# Ajustando o fuso horário
echo -e "${seta} ${azul}Ajustando o fuso horário${fim}"
sleep 2s
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
clear

# Executando hwclock
echo -e "${seta} ${azul}Executando o hwclock${fim}"
sleep 2s
hwclock --systohc --utc
clear

# Definindo o idioma
echo -e "${seta} ${azul}Definindo o idioma${fim}"
sleep 2s
sed -i 's/en_US ISO-8859-1/#en_US ISO-8859-1/' /etc/locale.gen
sed -i 's/en_US.UTF-8/#en_US.UTF-8/' /etc/locale.gen
sed -i 's/#pt_BR.UTF-8/pt_BR.UTF-8/' /etc/locale.gen
clear

# Gerando locale.gen
echo -e "${seta} ${azul}Gerando o locale-gen${fim}"
sleep 2s
locale-gen
clear

# Criando o arquivo locale.conf
echo -e "${seta} ${azul}Criando o arquivo locale.conf${fim}"
sleep 2s
echo LANG=pt_BR.UTF-8 > /etc/locale.conf
clear

# Exportando a variável LANG
echo -e "${seta} ${azul}Exportando a variável LANG${fim}"
sleep 2s
export LANG=pt_BR.UTF-8
clear

# Atualizando o relógio do sistema
echo -e "${seta} ${azul}Atualizando o relógio do sistema${fim}"
sleep 2s
timedatectl set-ntp true
clear

# Criando o arquivo vconsole.conf
echo -e "${seta} ${azul}Criando o arquivo vconsole.conf${fim}"
sleep 2s
echo KEYMAP=br-abnt2 > /etc/vconsole.conf
clear

# Criando o hostname
echo -e "${seta} ${azul}Criando o hostname${fim}"
sleep 2s
echo archlinux > /etc/hostname
clear

# Configurando o hosts
echo -e "${seta} ${azul}Configurando o arquivo hosts${fim}"
sleep 2s
cat >> '/etc/hosts' << EOF
127.0.0.1   localhost.localdomain   localhost
::1         localhost.localdomain   localhost
127.0.1.1   archlinux.localdomain   archlinux
EOF
clear

# Criando senha de root
echo -e "${seta} ${azul}Criando a senha do root${fim}"
sleep 2s
echo "root:$pass_root" | chpasswd
clear

# Baixando o Gerenciador de boot 
echo -e "${seta} ${azul}Baixando o Gerenciador de boot e mais alguns pacotes${fim}"
sleep 2s
pacman -S dosfstools efibootmgr git grub linux-headers networkmanager network-manager-applet vim wget xorg --noconfirm
clear

# Instalando o grub
echo -e "${seta} ${azul}Instalando o grub${fim}"
sleep 2s
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
clear

# Configurando o grub
echo -e "${seta} ${azul}Configurando o grub${fim}"
sleep 2s
grub-mkconfig -o /boot/grub/grub.cfg
clear

# Iniciando o NetworkManager
echo -e "${seta} ${azul}Iniciando o NetworkManager${fim}"
sleep 2s
systemctl enable NetworkManager
systemctl start NetworkManager
clear

# Adicionando um usuario
echo -e "${seta} ${azul}Adicionando o usuário${fim}"
sleep 2s
useradd -m -g users -G wheel fabio
clear

# Criando senha de usuario
echo -e "${seta} ${azul}Adicionando a senha do usuário${fim}"
sleep 2s
echo "$user:$pass_user" | chpasswd 
clear

# Adicionando user no grupo sudoers
echo -e "${seta} ${azul}Adicionando o usuário no grupo sudoers${fim}"
sleep 2s
sed -i '/root ALL=(ALL) ALL/a fabio ALL=(ALL) ALL' /etc/sudoers
clear

# Definindo lauout do teclado para pt-br
echo -e "${seta} ${azul}Definindo o layout do teclado no xorg${fim}"
sleep 2s
cat >> '/etc/X11/xorg.conf.d/10-keyboard.conf' << EOF
Section "InputClass"
    Identifier "keyboard default"
    MatchIsKeyboard "yes"
    Option "XkbLayout" "br"
    Option "XkbVariant" "abnt2"
fimSection
EOF
clear

# Reiniciando
echo -e "${seta} ${azul}Reinicie o sistema para continuar com a terceira parte!${fim}"
sleep 2s
exit
