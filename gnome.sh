#!/usr/bin/env bash
# --------------------------------------------------------
# Script        : [gnome.sh]
# Descrição     : Script para instalação do gnome e apps nescessários
# Versão        : 1.0
# Autor         : Fabio Junior Ribeiro
# Email         : rib3iro@live.com
# Data          : 11/12/2020
# Licença       : GNU/GPL v3.0
# --------------------------------------------------------
# Uso           : ./gnome.sh
# --------------------------------------------------------

source variaveis.sh
source funcoes.sh

# --------------------------------------------------------

clear
# Tela de boas vindas
echo -e "${S} ${C}Bem vindo a instalação do gnome${F}"

# Atualizando os espelhos
echo
echo -e "${S} ${C}Atualizando...${F}"
sudo pacman -Syu --noconfirm

# Lista de pacotes para instalar com o pacman
listapacman=(aircrack-ng alsa-utils arc-gtk-theme archlinux-keyring archlinux-wallpaper bash-completion bluez bluez-utils bully cmatrix cowpatty cronie cups dconf-editor dialog dosfstools efibootmgr fdupes firefox firefox-i18n-pt-br git gnome-desktop gnome-passwordsafe gnome-sound-recorder gnome-tweaks gnupg gst-libav gufw hashcat hcxdumptool hcxtools htop libreoffice libreoffice-fresh-pt-br lolcat lollypop man-db man-pages-pt_br mesa-demos mono mtools neofetch os-prober pass pulseaudio pulseaudio-bluetooth qbittorrent reaver rsync speedtest-cli tcpdump termshark ttf-dejavu ttf-fantasque-sans-mono ttf-hack ttf-jetbrains ttf-jetbrains-mono ufw unrar usbutils virtualbox wifite xclip youtube-dl)

# Lista de pacotes para instalar com o yay
listayay=(aic94xx-firmware ant-dracula-theme-git cava chrome-gnome-shell consolas-font crunch debtap downgrade gnome-terminal-transparency mintstick mint-y-icons onedriver pyrit sardi-icons spotify timeshift ttf-ms-fonts ttf-roboto ttf-ubuntu-font-family upd72020x-fw ventoy-bin wd719x-firmware)

# Instalando pacotes do gnome
listagnome=(baobab cheese docs eog evince file-roller gdm gnome gnome-backgrounds gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-color-manager gnome-control-center gnome-disk-utility gnome-documents gnome-font-viewer gnome-getting-started-docs gnome-keyring gnome-logs gnome-menus gnome-photos gnome-remote-desktop gnome-screenshot gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-system-monitor gnome-themes-extra gnome-user gnome-user-share gnome-video-effects gnome-weather grilo-plugins gvfs gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb mutter nautilus networkmanager orca rygel session simple-scan sushi totem tracker tracker3 tracker3-miners tracker-miners vino yelp)

echo
echo -e "${S} ${C}Instalando pacotes com pacman...${F}"
for i in ${listapacman[@]}
do
    echo -e "${S} ${C}Instalando o pacote $i ${F}"
    sudo pacman -S $i --noconfirm
    echo -e "${S} ${G}Pacote $i instalado com sucesso!!${F}"
    echo
done

echo
echo -e "${S} ${C}Instalando pacotes do gnome...${F}"
for i in ${listagnome[@]}
do
    echo -e "${S} ${C}Instalando o pacote $i ${F}"
    sudo pacman -S $i --noconfirm
    echo -e "${S} ${G}Pacote $i instalado com sucesso!!${F}"
    echo
done

# Instalando o yay
echo
echo -e "${S} ${C}Instalando o yay......${F}"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

echo
echo -e "${S} ${C}Instalando pacotes com yay...${F}"
for i in ${listayay[@]}
do
    echo -e "${S} ${C}Instalando o pacote $i ${F}"
    yay -S $i --noconfirm
    echo -e "${S} ${G}Pacote $i instalado com sucesso!!${F}"
    echo
done

# Bluez
echo
echo -e "${S} ${C}Iniciando o bluez...${F}"
sudo systemctl enable bluetooth
sudo systemctl start bluetooth
sudo systemctl enable org.cups.cupsd

# Gnome Display Manager
echo
echo -e "${S} ${C}Instalando o Gnome Display Manager...${F}"
sudo systemctl enable gdm.service
sudo systemctl start gdm.service

