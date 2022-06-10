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
clear

# --------------------------------------------------------

echo -e "${s} ${b}Bem vindo a segunda parte da instalação do ArchLinux UEFI/GPT${f}"
sleep 2s

# Ajustando o fuso horário
echo
echo -e "${s} ${b}Ajustando o fuso horário...${f}"
sleep 2s
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

# Executando hwclock
echo
echo -e "${s} ${b}Executando o hwclock...${f}"
sleep 2s
hwclock --systohc

# Definindo o idioma
echo
echo -e "${s} ${b}Definindo o idioma...${f}"
sleep 2s
sed -i 's/#pt_BR.UTF-8/pt_BR.UTF-8/' /etc/locale.gen
locale-gen

# Criando o arquivo locale.conf
echo
echo -e "${s} ${b}Criando o arquivo locale.conf...${f}"
sleep 2s
echo LANG=pt_BR.UTF-8 > /etc/locale.conf

# Exportando a variável LANG
echo
echo -e "${s} ${b}Exportando a variável LANG...${f}"
sleep 2s
export LANG=pt_BR.UTF-8

# Atualizando o relógio do sistema
echo
echo -e "${s} ${b}Atualizando o relógio do sistema...${f}"
sleep 2s
timedatectl set-ntp true

# Criando o arquivo vconsole.conf
echo
echo -e "${s} ${b}Criando o arquivo vconsole.conf...${f}"
sleep 2s
echo KEYMAP=br-abnt2 > /etc/vconsole.conf

# Criando o nome da máquina
echo
echo -en "${s} ${b}Digite o nome da máquina: ${f}"
read -e maquina
echo $maquina > /etc/hostname

# Configurando o hosts
echo
echo -e "${s} ${b}Configurando o arquivo hosts...${f}"
sleep 2s
cat >> '/etc/hosts' << EOF
127.0.0.1   localhost.localdomain localhost
::1         localhost.localdomain localhost
127.0.1.1   $maquina.localdomain $maquina
EOF

# Baixando o Gerenciador de boot
echo
echo -e "${s} ${b}Baixando o grub e mais alguns pacotes...${f}"
sleep 2s
pacman -S dialog dosfstools efibootmgr git grub intel-ucode linux-headers mtools networkmanager network-manager-applet nm-connection-editor pavucontrol pulseaudio terminus-font vim wget xdg-user-dirs xdg-utils xorg --noconfirm

# Instalando o grub
echo
echo -e "${s} ${b}Instalando o grub...${f}"
sleep 2s
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB

# Configurando o grub
echo
echo -e "${s} ${b}Configurando o grub...${f}"
sleep 2s
grub-mkconfig -o /boot/grub/grub.cfg

# Iniciando o NetworkManager
echo
echo -e "${s} ${b}Iniciando os Serviços NetworkManager...${f}"
sleep 2s
systemctl enable NetworkManager
systemctl start NetworkManager

# Criando senha de root
echo
senharoot

# Criando usuario e senha
echo
echo -e "${s} ${b}Criando usuário e senha...${f}"
usuario

# Adicionando user no grupo sudoers
echo
echo -e "${s} ${b}Adicionando o $usuario no grupo sudoers...${f}"
sleep 2s
sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Colorindo a sída do pacman
echo
echo -e "${s} ${b}Colorindo a saída do pacman...${f}"
sleep 2s
sed -i 's/#Color/Color/' /etc/pacman.conf

# xdg-user-dirs
echo
echo -e "${s} ${b}Iniciando o xdg-update...${f}"
sleep 2s
xdg-user-dirs-update

# Mudando o layout do teclado no xorg
echo
echo -e "${s} ${b}Definindo o layout do teclado no xorg...${f}"
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
echo -e "${s} ${g}Instalação finalizada!...${f}"
sleep 2s
exit
