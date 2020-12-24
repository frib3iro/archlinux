#!/usr/bin/env bash

# variaveis e password root/user
user='fabio'
pass_user='123'
pass_root='123'

R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
C='\033[0;36m'
F='\033[0m'
S='\e[32;1m>>>\e[m'

# Funções
arquivo_swap(){
    dd if=/dev/zero of=/swapfile bs=1M count=2048 status=progress
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo "/swapfile none swap defaults 0 0" >> /etc/fstab 
}

clear
echo -e "${S} ${C}Bem vindo a segunda parte da instalação do Arch Linux no modo UEFI${F}"
sleep 2
clear

# Criando o arquivo de swap
echo -e "${S} ${C}Criar o arquivo de swap < s/n >${F}"
echo -en "\n${S} ${Y}Qual sua resposta: ${F}"
read resposta
clear

if [ "$resposta" = 's' ]
then
    echo -e "${S} ${C}Criando o arquivo de swap${F}"
    sleep 2
    arquivo_swap
    clear
elif [ "$resposta" = 'n' ]
then
    echo -e "${S} ${C}O sistema será instalado sem o arquivo de swap${F}"
    sleep 2
    clear
else
    echo -e "${S} ${R}Resposta inválida!${F}"
    exit 1
fi 

# Ajustando o fuso horário
echo -e "${S} ${C}Ajustando o fuso horário${F}"
sleep 2
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
clear

# Executando hwclock
echo -e "${S} ${C}Executando o hwclock${F}"
sleep 2
hwclock --systohc --utc
clear

# Definindo o idioma
echo -e "${S} ${C}Definindo o idioma${F}"
sleep 2
sed -i 's/en_US ISO-8859-1/#en_US ISO-8859-1/' /etc/locale.gen
sed -i 's/en_US.UTF-8/#en_US.UTF-8/' /etc/locale.gen
sed -i 's/#pt_BR.UTF-8/pt_BR.UTF-8/' /etc/locale.gen
sed -i 's/#pt_BR ISO-8859-1/pt_BR ISO-8859-1/' /etc/locale.gen
clear

# Gerando locale.gen
echo -e "${S} ${C}Gerando o locale-gen${F}"
sleep 2
locale-gen
clear

# Criando o arquivo locale.conf
echo -e "${S} ${C}Criando o arquivo locale.conf${F}"
sleep 2
echo LANG=pt_BR.UTF-8 > /etc/locale.conf
clear

# Exportando a variável LANG
echo -e "${S} ${C}Exportando a variável LANG${F}"
sleep 2
export LANG=pt_BR.UTF-8
clear

# Atualizando o relógio do sistema
echo -e "${S} ${C}Atualizando o relógio do sistema${F}"
sleep 2
timedatectl set-ntp true
clear

# Criando o arquivo vconsole.conf
echo -e "${S} ${C}Criando o arquivo vconsole.conf${F}"
sleep 2
echo KEYMAP=br-abnt2 > /etc/vconsole.conf
echo FONT=ter-122n >> /etc/vconsole.conf
clear

# Criando o hostname
echo -e "${S} ${C}Criando o hostname${F}"
sleep 2
echo archlinux > /etc/hostname
clear

# Configurando o hosts
echo -e "${S} ${C}Configurando o arquivo hosts${F}"
sleep 2
cat >> '/etc/hosts' << EOF
127.0.0.1   localhost.localdomain   localhost
::1         localhost.localdomain   localhost
127.0.1.1   archlinux.localdomain   archlinux
EOF
clear

# Criando senha de root
echo -e "${S} ${C}Criando a senha do root${F}"
sleep 2
echo "root:$pass_root" | chpasswd
clear

# Baixando o Gerenciador de boot 
echo -e "${S} ${C}Baixando o Gerenciador de boot e mais alguns pacotes${F}"
sleep 2
pacman -S dialog dosfstools efibootmgr git grub linux-headers mtools networkmanager network-manager-applet vim wget xorg --noconfirm
clear

# Instalando o grub
echo -e "${S} ${C}Instalando o grub${F}"
sleep 2
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
clear

# Configurando o grub
echo -e "${S} ${C}Configurando o grub${F}"
sleep 2
grub-mkconfig -o /boot/grub/grub.cfg
clear

# Iniciando o NetworkManager
echo -e "${S} ${C}Iniciando os Serviços NetworkManager${F}"
sleep 2
systemctl enable NetworkManager
systemctl start NetworkManager
clear

# Adicionando um usuario
echo -e "${S} ${C}Adicionando o usuário${F}"
sleep 2
useradd -m -g users -G wheel fabio
clear

# Criando senha de usuario
echo -e "${S} ${C}Adicionando a senha do usuário${F}"
sleep 2
echo "$user:$pass_user" | chpasswd 
clear

# Adicionando user no grupo sudoers
echo -e "${S} ${C}Adicionando o usuário no grupo sudoers${F}"
sleep 2
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
clear

# Colorindo a sída do pacman
echo -e "${S} ${C}Colorindo a saída do pacman${F}"
sleep 2
sed -i 's/#Color/Color/' /etc/pacman.conf
clear

# Definindo lauout do teclado para pt-br
echo -e "${S} ${C}Definindo o layout do teclado no xorg${F}"
sleep 2
cat >> '/etc/X11/xorg.conf.d/10-keyboard.conf' << EOF
Section "InputClass"
    Identifier "keyboard default"
    MatchIsKeyboard "yes"
    Option "XkbLayout" "br"
    Option "XkbVariant" "abnt2"
fimSection
EOF
clear

# Fstab
echo -e "${S} ${C}Configurando o fstab${F}"
sleep 2
cat >> '/etc/fstab' << EOF

# /dev/sdb
UUID=c5558c52-c837-45a6-af29-11a65a9bd76b /mnt    ext4    defaults    0 1
EOF
clear

# Reiniciando
echo -e "${S} ${C}Reinicie o sistema para continuar com a terceira parte!${F}"
sleep 2
exit 

