#!/usr/bin/env bash

# variaveis e password root/user
user='fabio'
pass_user='123'
pass_root='123'
azul='\e[34;1m'
verde='\e[32;1m'
vermelho='\e[31;1m'
amarelo='\e[33;1m'
fim='\e[m'
seta='\e[32;1m==>\e[m'

clear
echo -e "${seta} ${azul}Bem vindo a segunda parte da instalação do Arch Linux!${fim}"
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

