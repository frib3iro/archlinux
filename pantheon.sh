#!/usr/bin/env bash
#----------------------------------------------------------------------
# Script : phanteon.sh
# Descrição :
# Versão : 0.1
# Autor : Fabio Junior Ribeiro <rib3iro@live.com>
# Data : 30/11/2020
# Licença : GNU/GPL v3.0
#----------------------------------------------------------------------
# Uso :
#----------------------------------------------------------------------

# variaveis e password
pass_user='123'
vermelho='\033[0;31m'
verde='\033[0;32m'
amarelo='\033[0;33m'
ciano='\033[0;36m'
fim='\033[0m'
seta='\e[32;1m-->\e[m'

# Tela de boas vindas
clear
echo -e "${seta} ${ciano}Instalando o Pantheon no Arch Linux${fim}"
sleep 2s
clear

echo -e "${seta} ${ciano}fazendo backup do pacman.conf${fim}"
sleep 2s
sudo cp /etc/pacman.conf /etc/pacman.conf.bk

echo -e "${seta} ${ciano}Adicionando o repositório alucryd a lista de repositórios do Arch${fim}"
sleep 2s
echo -e "\n[extra-alucryd]\nServer = https://pkgbuild.com/~alucryd/\$repo/\$arch\n" | sudo tee -a /etc/pacman.conf

# Atualizando os espelhos
echo -e "${seta} ${ciano}Atualizando...${fim}"
sleep 2s
echo $pass_user | sudo -S pacman -Syyu --noconfirm
clear

# Instalando o yay -------------------------------------------------------
echo -e "${seta} ${ciano}Instalando o yay${fim}"
sleep 2s
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
yay --sortby popularity --topdown --nodiffmenu --save
clear

# Instalando pacotes ----------------------------------------------------
echo -e "${seta} ${ciano}Instalando pacotes necessários${fim}"
yay -S pantheon-session --noconfirm
yay -S pantheon-default-settings --noconfirm
yay -S gnome-settings-daemon-elementary --noconfirm
yay -S pantheon-polkit-agent --noconfirm
yay -S ttf-opensans ttf-dejavu ttf-raleway ttf-liberation ttf-droid gnu-free-fonts --noconfirm
yay -S pantheon-files pantheon-terminal pantheon-code pantheon-calculator pantheon-videos pantheon-screenshot  pantheon-photos --noconfirm
yay -S contractor file-roller --noconfirm
yay -S wingpanel-indicator-session wingpanel-indicator-power wingpanel-indicator-sound wingpanel-indicator-bluetooth wingpanel-indicator-datetime wingpanel-indicator-notifications wingpanel-indicator-network wingpanel-indicator-nightlight wingpanel-indicator-keyboard --noconfirm
yay -S switchboard-plug-user-accounts switchboard-plug-sound switchboard-plug-sharing switchboard-plug-security-privacy switchboard-plug-printers switchboard-plug-power switchboard-plug-parental-controls switchboard-plug-notifications switchboard-plug-network switchboard-plug-mouse-touchpad switchboard-plug-locale switchboard-plug-keyboard switchboard-plug-display switchboard-plug-desktop switchboard-plug-datetime switchboard-plug-bluetooth switchboard-plug-applications switchboard-plug-about switchboard-plug-ally --noconfirm
yay -S switchboard-plug-elementary-tweaks-git --noconfirm

echo "Editar o arquivo como abaixo"
echo "RequiredComponents=gala;gala-daemon;"
sudo vim /usr/shar/gnome-session/sessions/pantheon.session
# Urutau-Icons -----------------------------------------------------------
echo -e "${seta} ${ciano}Instalando o Urutau-Icons${fim}"
sleep 2s
yay -S urutau-icons-git
gsettings set org.gnome.desktop.interface icon-theme "urutau-icons"
clear

# Google-chrome ---------------------------------------------------------
echo -e "${seta} ${ciano}Instalando o google-chrome${fim}"
sleep 2s
yay -S google-chrome --noconfirm
clear

# Fontes ----------------------------------------------------------------
echo -e "${seta} ${ciano}Instalando as fontes${fim}"
sleep 2s
yay -S ttf-ms-fonts --noconfirm
yay -S ttf-roboto --noconfirm
yay -S ttf-ubuntu-font-family --noconfirm
clear

# Definindo gerenciador de login ------------------------------------------
echo -e "${seta} ${ciano}Definindo o Lightdm como gerenciador de login padrão${fim}"
sleep 2s
yay -S lightdm-pantheon-greeter --noconfirm
echo $pass_user | sudo -S systemctl start lightdm && systemctl enable lightdm
clear

# Instalação finalizada -------------------------------------------------
echo -e "${seta} ${verde}Instalação finalizada!${fim}"

