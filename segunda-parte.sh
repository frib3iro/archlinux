#!/usr/bin/env bash

# variaveis e password root/user
user='fabio'
pass_user='123'
pass_root='123'
ciano='\033[0;36m'
verde='\033[0;32m'
vermelho='\033[0;31m'
amarelo='\033[0;32m'
fim='\033[0m'
seta='\e[32;1m-->\e[m'

## Funções ------------------------------------------------------
arquivo_swap(){
    fallocate -l 1GB /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo "/swapfile none swap defaults 0 0" >> /etc/fstab 
}
## Fim funções --------------------------------------------------

clear
echo -e "${seta} ${ciano}Bem vindo a segunda parte da instalação do Arch Linux!${fim}"
sleep 2s
clear

# Criando o arquivo de swap
echo -e "${seta} ${ciano}Criar o arquivo de swap < s/n >${fim} "
echo -en "\n${seta} ${amr}Qual sua resposta:${fim} "
read resposta
clear
if [ "$resposta" = 's' ]; then
    echo -e "${seta} ${ciano}Criando o arquivo de swap${fim}"
    sleep 2s
    arquivo_swap
    clear
elif [ "$resposta" = 'n' ]; then
    echo -e "${seta} ${ciano}O sistema será instalado sem o arquivo de swap${fim}"
    sleep 2s
    clear
else
    echo -e "${seta} ${vermelho}Resposta inválida!${fim}"
    exit 1
fi 

# Ajustando o fuso horário
echo -e "${seta} ${ciano}Ajustando o fuso horário${fim}"
sleep 2s
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
clear

# Executando hwclock
echo -e "${seta} ${ciano}Executando o hwclock${fim}"
sleep 2s
hwclock --systohc --utc
clear

# Definindo o idioma
echo -e "${seta} ${ciano}Definindo o idioma${fim}"
sleep 2s
sed -i 's/en_US ISO-8859-1/#en_US ISO-8859-1/' /etc/locale.gen
sed -i 's/en_US.UTF-8/#en_US.UTF-8/' /etc/locale.gen
sed -i 's/#pt_BR.UTF-8/pt_BR.UTF-8/' /etc/locale.gen
clear

# Gerando locale.gen
echo -e "${seta} ${ciano}Gerando o locale-gen${fim}"
sleep 2s
locale-gen
clear

# Criando o arquivo locale.conf
echo -e "${seta} ${ciano}Criando o arquivo locale.conf${fim}"
sleep 2s
echo LANG=pt_BR.UTF-8 > /etc/locale.conf
clear

# Exportando a variável LANG
echo -e "${seta} ${ciano}Exportando a variável LANG${fim}"
sleep 2s
export LANG=pt_BR.UTF-8
clear

# Atualizando o relógio do sistema
echo -e "${seta} ${ciano}Atualizando o relógio do sistema${fim}"
sleep 2s
timedatectl set-ntp true
clear

# Criando o arquivo vconsole.conf
echo -e "${seta} ${ciano}Criando o arquivo vconsole.conf${fim}"
sleep 2s
echo KEYMAP=br-abnt2 > /etc/vconsole.conf
clear

# Criando o hostname
echo -e "${seta} ${ciano}Criando o hostname${fim}"
sleep 2s
echo archlinux > /etc/hostname
clear

# Configurando o hosts
echo -e "${seta} ${ciano}Configurando o arquivo hosts${fim}"
sleep 2s
cat >> '/etc/hosts' << EOF
127.0.0.1   localhost.localdomain   localhost
::1         localhost.localdomain   localhost
127.0.1.1   archlinux.localdomain   archlinux
EOF
clear

# Criando senha de root
echo -e "${seta} ${ciano}Criando a senha do root${fim}"
sleep 2s
echo "root:$pass_root" | chpasswd
clear

# Baixando o Gerenciador de boot 
echo -e "${seta} ${ciano}Baixando o Gerenciador de boot e mais alguns pacotes${fim}"
sleep 2s
pacman -S dialog dosfstools efibootmgr git grub linux-headers mtools networkmanager network-manager-applet vim wget xorg --noconfirm
clear

# Instalando o grub
echo -e "${seta} ${ciano}Instalando o grub${fim}"
sleep 2s
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
clear

# Configurando o grub
echo -e "${seta} ${ciano}Configurando o grub${fim}"
sleep 2s
grub-mkconfig -o /boot/grub/grub.cfg
clear

# Iniciando o NetworkManager
echo -e "${seta} ${ciano}Iniciando o NetworkManager${fim}"
sleep 2s
systemctl enable NetworkManager
systemctl start NetworkManager
clear

# Adicionando um usuario
echo -e "${seta} ${ciano}Adicionando o usuário${fim}"
sleep 2s
useradd -m -g users -G wheel fabio
clear

# Criando senha de usuario
echo -e "${seta} ${ciano}Adicionando a senha do usuário${fim}"
sleep 2s
echo "$user:$pass_user" | chpasswd 
clear

# Adicionando user no grupo sudoers
echo -e "${seta} ${ciano}Adicionando o usuário no grupo sudoers${fim}"
sleep 2s
sed -i '/root ALL=(ALL) ALL/a fabio ALL=(ALL) ALL' /etc/sudoers
clear

# Colorindo a sída do pacman ----------------------------------
echo -e "${seta} ${ciano}Colorindo a saída do pacman${fim}"
sleep 2s
sed -i 's/#Color/Color/' /etc/pacman.conf
clear

# Definindo lauout do teclado para pt-br
echo -e "${seta} ${ciano}Definindo o layout do teclado no xorg${fim}"
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
echo -e "${seta} ${ciano}Reinicie o sistema para continuar com a terceira parte!${fim}"
sleep 2s
exit 

