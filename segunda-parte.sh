#!/usr/bin/env bash

# variaveis e password root/user
user='fabio'
pass_user='cp1113bug6u'
pass_root='cp1211rmcc3'
blue='\e[34;1m'
green='\e[32;1m'
red='\e[31;1m'
yellow='\e[33;1m'
end='\e[m'
seta='\e[32;1m==>\e[m'

clear
echo -e "${seta} ${blue}Bem vindo a segunda parte da instalação do Arch Linux!${end}"
sleep 2s
clear

# Listando os discos
echo -e "${seta} ${blue}Listando os discos${end}"
sleep 2s
lsblk -l | grep disk

# Informando o nome do seu disco
echo -en "\n${seta} ${blue}Informe o nome do seu disco:${end} "
read resp
disco=/dev/${resp}
clear

# # Criando o arquivo de swap 1
# echo -e "${seta} ${blue}Criando o arquivo de swap${end}"
# sleep 2s
# dd if=/dev/zero of=/var/swap.img bs=1024k count=4000
# mkswap /var/swap.img
# echo "/var/swap.img none swap sw   0  0" >> /etc/fstab
# cat /etc/fstab
# sleep 3s
# clear

# Criando o arquivo de swap 2
echo -e "${seta} ${blue}Criando o arquivo de swap${end}"
sleep 2s
dd if=/dev/$disco of=/swapfile bs=2G count=1
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
cat /etc/fstab
sleep 3s
clear

# # Criando o arquivo de swap 3
# echo -e "${seta} ${blue}Criando o arquivo de swap${end}"
# sleep 2s
# fallocate -l 2GB /swapfile
# chmod 600 /swapfile
# mkswap /swapfile
# swapon /swapfile
# echo "/swapfile none swap defaults 0 0" >> /etc/fstab 
# clear

# Ajustando o fuso horário
echo -e "${seta} ${blue}Ajustando o fuso horário${end}"
sleep 2s
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
clear

# Executando hwclock
echo -e "${seta} ${blue}Executando o hwclock${end}"
sleep 2s
hwclock --systohc --utc
clear

# Definindo o idioma
echo -e "${seta} ${blue}Definindo o idioma${end}"
sleep 2s
sed -i 's/en_US ISO-8859-1/#en_US ISO-8859-1/' /etc/locale.gen
sed -i 's/en_US.UTF-8/#en_US.UTF-8/' /etc/locale.gen
sed -i 's/#pt_BR.UTF-8/pt_BR.UTF-8/' /etc/locale.gen
sed -i 's/#pt_BR ISO-8859-1/pt_BR ISO-8859-1/' /etc/locale.gen
clear

# Gerando locale.gen
echo -e "${seta} ${blue}Gerando o locale-gen${end}"
sleep 2s
locale-gen
clear

# Criando o arquivo locale.conf
echo -e "${seta} ${blue}Criando o arquivo locale.conf${end}"
sleep 2s
echo LANG=pt_BR.UTF-8 > /etc/locale.conf
clear

# Exportando a variável LANG
echo -e "${seta} ${blue}Exportando a variável LANG${end}"
sleep 2s
export LANG=pt_BR.UTF-8
clear

# Atualizando o relógio do sistema
echo -e "${seta} ${blue}Atualizando o relógio do sistema${end}"
sleep 2s
timedatectl set-ntp true
clear

# Criando o arquivo vconsole.conf
echo -e "${seta} ${blue}Criando o arquivo vconsole.conf${end}"
sleep 2s
echo KEYMAP=br-abnt2 > /etc/vconsole.conf
clear

# Criando o hostname
echo -e "${seta} ${blue}Criando o hostname${end}"
sleep 2s
echo archlinux > /etc/hostname
clear

# Configurando o hosts
echo -e "${seta} ${blue}Configurando o arquivo hosts${end}"
sleep 2s
cat >> '/etc/hosts' << EOF
127.0.0.1   localhost.localdomain   localhost
::1         localhost.localdomain   localhost
127.0.1.1   archlinux.localdomain   archlinux
EOF
clear

# Criando senha de root
echo -e "${seta} ${blue}Criando a senha do root${end}"
sleep 2s
echo "root:$pass_root" | chpasswd
clear

# Baixando o Gerenciador de boot 
echo -e "${seta} ${blue}Baixando o Gerenciador de boot e mais alguns pacotes${end}"
sleep 2s
pacman -S dosfstools efibootmgr git grub linux-headers networkmanager network-manager-applet vim wget xorg --noconfirm
clear

# Instalando o grub
echo -e "${seta} ${blue}Instalando o grub${end}"
sleep 2s
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
clear

# Configurando o grub
echo -e "${seta} ${blue}Configurando o grub${end}"
sleep 2s
grub-mkconfig -o /boot/grub/grub.cfg
clear

# Iniciando o NetworkManager
echo -e "${seta} ${blue}Iniciando o NetworkManager${end}"
sleep 2s
systemctl enable NetworkManager
systemctl start NetworkManager
clear

# Adicionando um usuario
echo -e "${seta} ${blue}Adicionando o usuário${end}"
sleep 2s
useradd -m -g users -G wheel fabio
clear

# Criando senha de usuario
echo -e "${seta} ${blue}Adicionando a senha do usuário${end}"
sleep 2s
echo "$user:$pass_user" | chpasswd 
clear

# Adicionando user no grupo sudoers
echo -e "${seta} ${blue}Adicionando o usuário no grupo sudoers${end}"
sleep 2s
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
clear

echo -e "${seta} ${blue}Definindo o layout do teclado no xorg${end}"
sleep 2s
cat >> '/etc/X11/xorg.conf.d/10-keyboard.conf' << EOF
Section "InputClass"
    Identifier "keyboard default"
    MatchIsKeyboard "yes"
    Option "XkbLayout" "br"
    Option "XkbVariant" "abnt2"
EndSection
EOF
clear

# Reiniciando
echo -e "${seta} ${blue}Reinicie o sistema para continuar com a terceira parte!${end}"
sleep 2s
exit 

