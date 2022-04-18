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
clear

# --------------------------------------------------------

# Lista de pacotes para instalar com o pacman
listapacman=(aircrack-ng alsa-utils arc-gtk-theme archlinux-keyring archlinux-wallpaper bash-completion bluez bluez-utils bully cmatrix cowpatty cronie cups dconf-editor dialog dosfstools efibootmgr fdupes firefox firefox-i18n-pt-br git gnome-desktop gnome-passwordsafe gnome-sound-recorder gnome-tweaks gnupg gst-libav gufw hashcat hcxdumptool hcxtools htop libreoffice libreoffice-fresh-pt-br lolcat lollypop man-db man-pages-pt_br mesa-demos mtools neofetch os-prober pass pulseaudio pulseaudio-bluetooth qbittorrent reaver rsync speedtest-cli tcpdump termshark ttf-dejavu ttf-fantasque-sans-mono ttf-hack ttf-jetbrains-mono ufw unrar usbutils virtualbox wifite xclip youtube-dl)

# Lista de pacotes para instalar com o paru
listaparu=(aic94xx-firmware ant-dracula-theme-git cava consolas-font crunch debtap downgrade gnome-terminal-transparency mintstick mint-y-icons onedriver pyrit sardi-icons spotify timeshift ttf-ms-fonts ttf-roboto ttf-ubuntu-font-family upd72020x-fw wd719x-firmware xcursor-breeze)

# Instalando pacotes do gnome
listagnome=(baobab cheese eog evince file-roller gdm gedit gedit-plugins gnome-backgrounds gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-color-manager gnome-control-center gnome-disk-utility gnome-documents gnome-font-viewer gnome-getting-started-docs gnome-keyring gnome-logs gnome-menus gnome-photos gnome-remote-desktop gnome-screenshot gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-system-monitor gnome-themes-extra gnome-user-docs gnome-user-share gnome-video-effects gnome-weather grilo-plugins gvfs gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb mutter nautilus networkmanager orca rygel simple-scan sushi totem tracker tracker3 tracker3-miners tracker-miners vino yelp)

# --------------------------------------------------------

# Tela de boas vindas
echo -e "${S} ${B}Bem vindo a instalação do gnome${F}"
sleep 2s

# Atualizando os espelhos
echo
echo -e "${S} ${B}Atualizando...${F}"
sleep 2s
sudo pacman -Syu --noconfirm

echo
echo -e "${S} ${B}Instalando pacotes com pacman...${F}"
sleep 2s
echo
for i in ${listapacman[@]}
do
    echo -e "${S} ${B}Instalando o pacote $i ${F}"
    echo
    sleep 2s
    if sudo pacman -S $i --noconfirm; then
        echo -e "${S} ${G}Pacote $i instalado com sucesso!${F}"
        sleep 2s
    else
        echo -e "${S} ${R}Houve erro na instalação do pacote $i!${F}"
        sleep 2s
    fi
done

echo
echo -e "${S} ${B}Instalando pacotes do gnome...${F}"
sleep 2s
echo
for i in ${listagnome[@]}
do
    echo -e "${S} ${B}Instalando o pacote $i ${F}"
    sleep 2s
    echo
    if sudo pacman -S $i --noconfirm; then
        echo -e "${S} ${G}Pacote $i instalado com sucesso!${F}"
        sleep 2s
    else
        echo -e "${S} ${R}Houve erro na instalação do pacote $i!${F}"
        sleep 2s
    fi
done

# Instalando o paru
echo
echo -e "${S} ${B}Instalando o paru...${F}"
sleep 2s
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
echo


# Instalando pacotes com o paru
echo
echo -e "${S} ${B}Instalando pacotes com paru...${F}"
sleep 2s
echo
for i in ${listaparu[@]}
do
    echo -e "${S} ${B}Instalando o pacote $i ${F}"
    sleep 2s
    echo
    if paru -S $i --noconfirm; then
        echo -e "${S} ${G}Pacote $i instalado com sucesso!${F}"
        sleep 2s
    else
        echo -e "${S} ${R}Houve erro na instalação do pacote $i!${F}"
        sleep 2s
    fi
done

# Apagando diretórios desnecessários
echo
echo -e "${S} ${B}Apagando o diretório paru e go...${F}"
sleep 2s
cd /home/fabio && rm -rf go paru

# Baixando tema dracula para gedit
echo
echo -e "${S} ${B}Baixando o tema dracula para o gedit...${F}"
sleep 2s
wget https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml
mkdir -p $HOME/.local/share/gedit/styles/
mv dracula.xml $HOME/.local/share/gedit/styles/

# Iniciando o bluez e o cups
echo
echo -e "${S} ${B}Iniciando o bluez e o cups...${F}"
sleep 2s
sudo systemctl enable bluetooth
sudo systemctl start bluetooth
sudo systemctl enable cups.service

# Iniciando o gnome display manager
echo
echo -e "${S} ${B}Instalando o Gnome Display Manager...${F}"
sleep 2s
sudo systemctl enable gdm.service
sudo systemctl start gdm.service

