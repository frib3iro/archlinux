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
listapacman=(aircrack-ng wifite tcpdump bully reaver hcxdumptool hcxtools termshark cowpatty hashcat fdupes firefox firefox-i18n-pt-br arc-gtk-theme alsa-utils dconf-editor gnome-passwordsafe gnome-sound-recorder archlinux-keyring archlinux-wallpaper bash-completion bluez bluez-utils cmatrix cronie dialog dosfstools efibootmgr git gnome-tweaks gnupg gst-libav gufw htop libreoffice libreoffice-fresh-pt-br lolcat man-db man-pages-pt_br mesa-demos mtools neofetch os-prober pass rsync qbittorrent speedtest-cli ufw unrar xclip youtube-dl pulseaudio pulseaudio-bluetooth lollypop usbutils ttf-fantasque-sans-mono ttf-jetbrains-mono ttf-dejavu ttf-hack ttf-jetbrains-mono gnome-desktop virtualbox)

# Lista de pacotes para instalar com o yay
listaparu=(xcursor-breeze pyrit aic94xx-firmware consolas-font wd719x-firmware upd72020x-fw mintstick downgrade timeshift crunch gnome-terminal-transparency cava mint-y-icons sardi-icons ant-dracula-theme-git debtap spotify ttf-ms-fonts ttf-roboto ttf-ubuntu-font-family onedriver)

# Instalando pacotes do gnome
listagnome=(baobab cheese eog evince file-roller gdm gnome-backgrounds gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-color-manager gnome-control-center gnome-disk-utility gnome-documents gnome-font-viewer gnome-getting-started-docs gnome-keyring gnome-logs gnome-menus gnome-photos gnome-remote-desktop gnome-screenshot gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-system-monitor gnome-themes-extra gnome-user-docs gnome-user-share gnome-video-effects gnome-weather grilo-plugins gvfs gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb mutter nautilus networkmanager orca rygel sushi totem tracker tracker-miners tracker3 tracker3-miners vino yelp simple-scan)

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
echo -e "${S} ${B}Instalando pacotes com paru...${F}"
echo
for i in ${listaparu[@]}
do
    echo -e "${S} ${B}Instalando o pacote $i ${F}"
    paru -S $i --noconfirm
    echo -e "${S} ${G}Pacote $i instalado com sucesso!!${F}"
    echo
done

# Bluez
echo
echo -e "${S} ${B}Iniciando o bluez...${F}"
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Gnome Display Manager
echo
echo -e "${S} ${B}Instalando o Gnome Display Manager...${F}"
sudo systemctl enable gdm.service
sudo systemctl start gdm.service

