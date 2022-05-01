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
sleep 2s

# Atualizando os espelhos
echo
echo -e "${s} ${b}Atualizando...${f}"
sleep 2s
sudo pacman -Syu --noconfirm

echo
echo -e "${s} ${b}Instalando pacotes com pacman...${f}"
sleep 2s

for i in ${listapacman[@]}
do
	echo
    echo -e "${s} ${b}Instalando o pacote $i ${f}"
    sleep 2s
    if sudo pacman -S $i --noconfirm; then
        echo -e "${s} ${g}Pacote $i instalado com sucesso!${f}"
        sleep 2s
    else
        echo -e "${s} ${r}Houve erro na instalação do pacote $i!${f}"
        sleep 2s
    fi
done

echo
echo -e "${s} ${b}Instalando pacotes do gnome...${f}"
sleep 2s

for i in ${listagnome[@]}
do
	echo
    echo -e "${s} ${b}Instalando o pacote $i ${f}"
    sleep 2s
    if sudo pacman -S $i --noconfirm; then
        echo -e "${s} ${g}Pacote $i instalado com sucesso!${f}"
        sleep 2s
    else
        echo -e "${s} ${r}Houve erro na instalação do pacote $i!${f}"
        sleep 2s
    fi
done

# Instalando o yay
echo
echo -e "${s} ${b}Instalando o yay...${f}"
sleep 2s
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

# Instalando pacotes com o yay
echo
echo -e "${s} ${b}Instalando pacotes com yay...${f}"
sleep 2s

for i in ${listayay[@]}
do
	echo
    echo -e "${s} ${b}Instalando o pacote $i ${f}"
    sleep 2s
    if yay -S $i --noconfirm; then
        echo -e "${s} ${g}Pacote $i instalado com sucesso!${f}"
        sleep 2s
    else
        echo -e "${s} ${r}Houve erro na instalação do pacote $i!${f}"
        sleep 2s
    fi
done

# Apagando diretórios desnecessários
echo
echo -e "${s} ${b}Apagando o diretório yay e go...${f}"
sleep 2s
cd /home/fabio && rm -rf go yay

# Baixando tema dracula para gedit
echo
echo -e "${s} ${b}Baixando o tema dracula para o gedit...${f}"
sleep 2s
wget https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml
mkdir -p $HOME/.local/share/gedit/styles/
mv dracula.xml $HOME/.local/share/gedit/styles/

# Iniciando o bluez e o cups
echo
echo -e "${s} ${b}Iniciando o bluez e o cups...${f}"
sleep 2s
sudo systemctl enable bluetooth
sudo systemctl start bluetooth
sudo systemctl enable cups.service

# Iniciando o gnome display manager
echo
echo -e "${s} ${b}Instalando o Gnome Display Manager...${f}"
sleep 2s
sudo systemctl enable gdm.service
sudo systemctl start gdm.service

