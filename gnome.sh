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
echo -e "${S} ${B}Bem vindo a instalação do gnome${F}"

# Atualizando os espelhos
echo
echo -e "${S} ${B}Atualizando...${F}"
sudo pacman -Syu --noconfirm

# Lista de pacotes para instalar com o pacman
listapacman=(aircrack-ng alsa-utils arc-gtk-theme archlinux-keyring archlinux-wallpaper bash-completion bluez bluez-utils bully cmatrix cowpatty cronie cups dconf-editor dialog dosfstools efibootmgr fdupes firefox firefox-i18n-pt-br git gnome-desktop gnome-passwordsafe gnome-sound-recorder gnome-tweaks gnupg gst-libav gufw hashcat hcxdumptool hcxtools htop libreoffice libreoffice-fresh-pt-br lolcat lollypop man-db man-pages-pt_br mesa-demos mtools neofetch os-prober pass pulseaudio pulseaudio-bluetooth qbittorrent reaver rsync speedtest-cli tcpdump termshark ttf-dejavu ttf-fantasque-sans-mono ttf-hack ttf-jetbrains-mono ufw unrar usbutils virtualbox wifite xclip youtube-dl)

# Lista de pacotes para instalar com o yay
listaparu=(aic94xx-firmware ant-dracula-theme-git cava consolas-font crunch debtap downgrade gnome-terminal-transparency mintstick mint-y-icons onedriver pyrit sardi-icons spotify timeshift ttf-ms-fonts ttf-roboto ttf-ubuntu-font-family upd72020x-fw wd719x-firmware xcursor-breeze)

# Instalando pacotes do gnome
listagnome=(baobab cheese eog evince file-roller gdm gedit gedit-plugins gnome-backgrounds gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-color-manager gnome-control-center gnome-disk-utility gnome-documents gnome-font-viewer gnome-getting-started-docs gnome-keyring gnome-logs gnome-menus gnome-photos gnome-remote-desktop gnome-screenshot gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-system-monitor gnome-themes-extra gnome-user-docs gnome-user-share gnome-video-effects gnome-weather grilo-plugins gvfs gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb mutter nautilus networkmanager orca rygel simple-scan sushi totem tracker tracker3 tracker3-miners tracker-miners vino yelp)

echo
echo -e "${S} ${B}Instalando pacotes com pacman...${F}"
echo
for i in ${listapacman[@]}
do
    echo -e "${S} ${B}Instalando o pacote $i ${F}"
    sudo pacman -S $i --noconfirm
    echo -e "${S} ${G}Pacote $i instalado com sucesso!!${F}"
    echo
done

echo
echo -e "${S} ${B}Instalando pacotes do gnome...${F}"
echo
for i in ${listagnome[@]}
do
    echo -e "${S} ${B}Instalando o pacote $i ${F}"
    sudo pacman -S $i --noconfirm
    echo -e "${S} ${G}Pacote $i instalado com sucesso!!${F}"
    echo
done

# Instalando o paru
echo
echo -e "${S} ${B}Instalando o paru...${F}"
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
echo
echo -e "${S} ${B}Apagando o diretório paru e go...${F}"
cd /home/fabio && rm -rf go paru

echo
echo -e "${S} ${B}Instalando pacotes com paru...${F}"
echo
for i in ${listaparu[@]}
do
    echo -e "${S} ${B}Instalando o pacote $i ${F}"
    paru -S $i --noconfirm
    echo -e "${S} ${G}Pacote $i instalado com sucesso!!${F}"
    echo
done

echo
echo -e "${S} ${B}Baixando o tema dracula para o gedit...${F}"
wget https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml
mkdir -p $HOME/.local/share/gedit/styles/
mv dracula.xml $HOME/.local/share/gedit/styles/


# Bluez
echo
echo -e "${S} ${B}Iniciando o bluez e o cups...${F}"
sudo systemctl enable bluetooth
sudo systemctl start bluetooth
sudo systemctl enable cups.service

# Gnome Display Manager
echo
echo -e "${S} ${B}Instalando o Gnome Display Manager...${F}"
sudo systemctl enable gdm.service
sudo systemctl start gdm.service

