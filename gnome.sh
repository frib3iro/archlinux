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
source listas.sh

# --------------------------------------------------------

clear
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
for i in ${listapacman[@]}
do
    echo -e "${S} ${B}Instalando o pacote $i ${F}"
    sleep 2s
    sudo pacman -S $i --noconfirm
    echo -e "${S} ${G}Pacote $i instalado com sucesso!!${F}"
    sleep 2s
    echo
done

echo
echo -e "${S} ${B}Instalando pacotes do gnome...${F}"
sleep 2s
for i in ${listagnome[@]}
do
    echo -e "${S} ${B}Instalando o pacote $i ${F}"
    sleep 2s
    sudo pacman -S $i --noconfirm
    echo -e "${S} ${G}Pacote $i instalado com sucesso!!${F}"
    sleep 2s
    echo
done

# Instalando o yay
echo
echo -e "${S} ${B}Instalando o yay......${F}"
sleep 2s
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

echo
echo -e "${S} ${B}Instalando pacotes com yay...${F}"
sleep 2s
for i in ${listayay[@]}
do
    echo -e "${S} ${B}Instalando o pacote $i ${F}"
    sleep 2s
    yay -S $i --noconfirm
    echo -e "${S} ${G}Pacote $i instalado com sucesso!!${F}"
    sleep 2s
    echo
done

# Bluez
echo
echo -e "${S} ${B}Iniciando o bluez...${F}"
sleep 2s
sudo systemctl enable bluetooth
sudo systemctl start bluetooth
sudo systemctl enable org.cups.cupsd

# Gnome Display Manager
echo
echo -e "${S} ${B}Instalando o Gnome Display Manager...${F}"
sleep 2s
sudo systemctl enable gdm.service
sudo systemctl start gdm.service

