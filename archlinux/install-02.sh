#!/usr/bin/env bash

source variaveis.sh
source funcoes.sh

clear
echo -e "${seta} ${ciano}Bem vindo a segunda parte da instalação do Arch Linux!${fim}"
sleep 2s
clear

# Criando o arquivo de swap
echo -e "${seta} ${ciano}Criar o arquivo de swap < s/n >${fim} "
echo -en "\n${seta} ${amr}Qual sua resposta:${fim} "
read resposta
clear
if [ "$resposta" = 's' ]; then
    echo -e "${seta} ${ciano}Criando o arquivo de swap${fim}"
    sleep 2s
    arquivo_swap
    clear
elif [ "$resposta" = 'n' ]; then
    echo -e "${seta} ${ciano}O sistema será instalado sem o arquivo de swap${fim}"
    sleep 2s
    clear
else
    echo -e "${seta} ${vermelho}Resposta inválida!${fim}"
    exit 1
fi 

# Ajustando o fuso horário
echo -e "${seta} ${ciano}Ajustando o fuso horário${fim}"
sleep 2s
FusoHorario
clear

# Executando hwclock
echo -e "${seta} ${ciano}Executando o hwclock${fim}"
sleep 2s
ExecutandoHwclock
clear

# Definindo o idioma
echo -e "${seta} ${ciano}Definindo o idioma${fim}"
sleep 2s
DefinirIdioma
clear

# Criando o arquivo locale.conf
echo -e "${seta} ${ciano}Criando o arquivo locale.conf${fim}"
sleep 2s
CriandoLocaleConf
clear

# Exportando a variável LANG
echo -e "${seta} ${ciano}Exportando a variável LANG${fim}"
sleep 2s
EportandoVariavelLang
clear

# Atualizando o relógio do sistema
echo -e "${seta} ${ciano}Atualizando o relógio do sistema${fim}"
sleep 2s
timedatectl set-ntp true
clear

# Criando o arquivo vconsole.conf
echo -e "${seta} ${ciano}Criando o arquivo vconsole.conf${fim}"
sleep 2s
CriandoArquivoVconsoleConf
clear

# Criando o hostname
echo -e "${seta} ${ciano}Criando o hostname${fim}"
sleep 2s
CriandoHostname
clear

# Configurando o hosts
echo -e "${seta} ${ciano}Configurando o arquivo hosts${fim}"
sleep 2s
ConfigurandoHosts
clear

# Criando senha de root
echo -e "${seta} ${ciano}Criando a senha do root${fim}"
sleep 2s
CriandoSenhaRoot
clear

# Baixando o Gerenciador de boot 
echo -e "${seta} ${ciano}Baixando o Gerenciador de boot${fim}"
sleep 2s
GerenciadorDeBoot
clear

# Instalando o grub
echo -e "${seta} ${ciano}Instalando o grub${fim}"
sleep 2s
InstalandoGrub
clear

# Iniciando o NetworkManager
echo -e "${seta} ${ciano}Iniciando o NetworkManager${fim}"
sleep 2s
NetworkManager
clear

# Adicionando um usuario
echo -e "${seta} ${ciano}Adicionando o usuário${fim}"
sleep 2s
AdicionandoUsuario
clear

# Criando senha de usuario
echo -e "${seta} ${ciano}Adicionando a senha do usuário${fim}"
sleep 2s
AdicionandoSenhaUsuario
clear

# Adicionando user no grupo sudoers
echo -e "${seta} ${ciano}Adicionando o usuário no grupo sudoers${fim}"
sleep 2s
ConfigurandoSudoers
clear

# Colorindo a sída do pacman ----------------------------------
echo -e "${seta} ${ciano}Colorindo a saída do pacman${fim}"
sleep 2s
ColorindoSaidaPacman
clear

# Definindo lauout do teclado para pt-br
echo -e "${seta} ${ciano}Definindo o layout do teclado no xorg${fim}"
sleep 2s
DefinindoLayoutTecladoXorg
clear

# Reiniciando
echo -e "${seta} ${ciano}Reinicie o sistema para continuar com a terceira parte!${fim}"
sleep 2s
exit 

