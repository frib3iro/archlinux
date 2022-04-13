#!/usr/bin/env bash
# --------------------------------------------------------
# Script    : [install-02.sh]
# Descrição : Script para instalação do arch linux no modo UEFI
# Versão    : 1.0
# Autor     : Fabio Junior Ribeiro
# Email     : rib3iro@live.com
# Data      : 11/12/2020
# Licença   : GNU/GPL v3.0
# --------------------------------------------------------
# Uso       : Instala automático após instalar o script ./install-01.sh
# --------------------------------------------------------

source variaveis.sh
source funcoes.sh

# --------------------------------------------------------

clear

echo -e "${S} ${B}Bem vindo a segunda parte da instalação do ArchLinux UEFI/GPT${F}"
sleep 2s

# Ajustando o fuso horário
echo
echo -e "${S} ${B}Ajustando o fuso horário${F}"
sleep 2s
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

# Executando hwclock
echo
echo -e "${S} ${B}Executando o hwclock${F}"
sleep 2s
hwclock --systohc

# Definindo o idioma
echo
echo -e "${S} ${B}Definindo o idioma${F}"
sleep 2s
sed -i 's/#pt_BR.UTF-8/pt_BR.UTF-8/' /etc/locale.gen
locale-gen

# Criando o arquivo locale.conf
echo
echo -e "${S} ${B}Criando o arquivo locale.conf${F}"
sleep 2s
echo LANG=pt_BR.UTF-8 > /etc/locale.conf

# Exportando a variável LANG
echo
echo -e "${S} ${B}Exportando a variável LANG${F}"
sleep 2s
export LANG=pt_BR.UTF-8

# Atualizando o relógio do sistema
echo
echo -e "${S} ${B}Atualizando o relógio do sistema${F}"
sleep 2s
timedatectl set-ntp true

# Criando o arquivo vconsole.conf
echo
echo -e "${S} ${B}Criando o arquivo vconsole.conf${F}"
sleep 2s
cat >> '/etc/vconsole.conf' << EOF
KEYMAP=br-abnt2
FONT=ter-120n
EOF

# Criando o hostname
echo
echo -e "${S} ${B}Criando o hostname${F}"
sleep 2s
echo archlinux > /etc/hostname

# Configurando o hosts
echo
echo -e "${S} ${B}Configurando o arquivo hosts${F}"
sleep 2s
cat >> '/etc/hosts' << EOF
127.0.0.1   localhost.localdomain localhost
::1         localhost.localdomain localhost
127.0.1.1   archlinux.localdomain archlinux
EOF

# Initramfs
echo
echo -e "${S} ${B}Criando um novo initramfs${F}"
sleep 2s
mkinitcpio -P

# Criando senha de root
echo
echo -e "${S} ${B}Criando a senha do root${F}"
sleep 2s
echo
senharoot

# Baixando o Gerenciador de boot
echo
echo -e "${S} ${B}Baixando o Gerenciador de boot e mais alguns pacotes${F}"
sleep 2s
pacman -S dialog dosfstools efibootmgr git grub intel-ucode linux-headers mtools networkmanager network-manager-applet nm-connection-editor os-prober pavucontrol pulseaudio terminus-font vim wget xdg-user-dirs xdg-utils xorg --noconfirm

# Instalando o grub
echo
echo -e "${S} ${B}Instalando o grub${F}"
sleep 2s
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB

# Configurando o grub
echo
echo -e "${S} ${B}Configurando o grub${F}"
sleep 2s
grub-mkconfig -o /boot/grub/grub.cfg

# Iniciando o NetworkManager
echo
echo -e "${S} ${B}Iniciando os Serviços NetworkManager${F}"
sleep 2s
systemctl enable NetworkManager
systemctl start NetworkManager

# Criando usuario e senha
echo
echo -e "${S} ${B}Criando usuário e senha${F}"
sleep 2s
echo
usuario
senhauser

# Adicionando user no grupo sudoers
echo
echo -e "${S} ${B}Adicionando o $usuario no grupo sudoers${F}"
sleep 2s
sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Colorindo a sída do pacman
echo
echo -e "${S} ${B}Colorindo a saída do pacman${F}"
sleep 2s
sed -i 's/#Color/Color/' /etc/pacman.conf

# xdg-user-dirs
echo
echo -e "${S} ${B}Iniciando o xdg-update...${F}"
sleep 2s
xdg-user-dirs-update

# Mudando o layout do teclado no xorg
echo
echo -e "${S} ${B}Definindo o layout do teclado no xorg${F}"
sleep 2s
cat >> '/etc/X11/xorg.conf.d/10-keyboard.conf' << EOF
Section "InputClass"
    Identifier "keyboard default"
    MatchIsKeyboard "yes"
    Option "XkbLayout" "br"
    Option "XkbVariant" "abnt2"
EndSection
EOF

# Instalação finalizada
echo
echo -e "${S} ${R}Instalação finalizada!${F}"
sleep 2s
exit
