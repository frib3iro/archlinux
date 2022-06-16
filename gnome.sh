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
source listas.sh
source funcoes.sh

clear

# --------------------------------------------------------

# Tela de boas vindas
echo -e "${s} ${b}Bem vindo a instalação do gnome${f}"


# Atualizando os espelhos
echo
echo -e "${s} ${b}Atualizando...${f}"

sudo pacman -Syu --noconfirm

echo
echo -e "${s} ${b}Instalando pacotes com pacman...${f}"


for i in ${listapacman[@]}
do
	echo
    echo -e "${s} ${b}Instalando o pacote $i ${f}"
    
    if sudo pacman -S $i --noconfirm; then
        echo -e "${s} ${g}Pacote $i instalado com sucesso!${f}"
        
    else
        echo -e "${s} ${r}Houve erro na instalação do pacote $i!${f}"
        
    fi
done

echo
echo -e "${s} ${b}Instalando pacotes...${f}"


for i in ${pacotes[@]}
do
	echo
    echo -e "${s} ${b}Instalando o pacote $i ${f}"
    
    if sudo pacman -S $i --noconfirm; then
        echo -e "${s} ${g}Pacote $i instalado com sucesso!${f}"
        
    else
        echo -e "${s} ${r}Houve erro na instalação do pacote $i!${f}"
        
    fi
done

# Instalando o yay
echo
echo -e "${s} ${b}Instalando o yay...${f}"

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd /home/fabio && rm -rf go yay

# Instalando pacotes com o yay
echo
echo -e "${s} ${b}Instalando pacotes com yay...${f}"


for i in ${listayay[@]}
do
	echo
    echo -e "${s} ${b}Instalando o pacote $i ${f}"
    
    if yay -S $i --noconfirm; then
        echo -e "${s} ${g}Pacote $i instalado com sucesso!${f}"
        
    else
        echo -e "${s} ${r}Houve erro na instalação do pacote $i!${f}"
        
    fi
done

# Baixando tema dracula para gedit
echo
echo -e "${s} ${b}Baixando o tema dracula para o gedit...${f}"

wget https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml
mkdir -p $HOME/.local/share/gedit/styles/
mv dracula.xml $HOME/.local/share/gedit/styles/

# Iniciando o bluez e o cups
echo
echo -e "${s} ${b}Iniciando o bluez e o cups...${f}"

sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
sudo systemctl enable cups.service

# Instalando o openssh
echo -e "${s} ${b}Instalando o openssh${f}"
installssh
