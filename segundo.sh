#!/usr/bin/env bash
#----------------------------------------------------------------------
# Script    : segundo.sh
# Descrição :
# Versão    : 1.0
# Autor     : Fabio Junior Ribeiro
# Email     : rib3iro@live.com
# Data      : 28/11/2020
# Licença   : GNU/GPL v3.0
#----------------------------------------------------------------------
# Uso       : ./primeiro.sh
#----------------------------------------------------------------------
# Import das variaveis globais e funções
source variaveis.sh
source funcoes.sh
#----------------------------------------------------------------------

clear
echo -e "${S} ${C}Bem vindo a segunda parte da instalação do Arch Linuxi no modo UEFI${F}"
sleep 2
clear

# Criando o arquivo de swap
echo -e "${S} ${C}Criar o arquivo de swap [ s/n ]${F} "
echo -en "\n${S} ${Y}Qual sua resposta: ${F} "
read resposta
clear
if [ "$resposta" = 's' ]; then
    echo -e "${S} ${C}Criando o arquivo de swap${F}"
    sleep 2
    ArquivoSwap
    clear
elif [ "$resposta" = 'n' ]; then
    echo -e "${S} ${C}O sistema será instalado sem o arquivo de swap${F}"
    sleep 2
    clear
else
    echo -e "${S} ${R}Resposta inválida!${F}"
    exit 1
fi 

# Ajustando o fuso horário
echo -e "${S} ${C}Ajustando o fuso horário${F}"
sleep 2
FusoHorario
clear

# Executando hwclock
echo -e "${S} ${C}Executando o hwclock${F}"
sleep 2
ExecutandoHwclock
clear

# Definindo o idioma
echo -e "${S} ${C}Definindo o idioma${F}"
sleep 2
DefinirIdioma
clear

# Criando o arquivo locale.conf
echo -e "${S} ${C}Criando o arquivo locale.conf${F}"
sleep 2
CriandoLocaleConf
clear

# Exportando a variável LANG
echo -e "${S} ${C}Exportando a variável LANG${F}"
sleep 2
EportandoVariavelLang
clear

# Atualizando o relógio do sistema
echo -e "${S} ${C}Atualizando o relógio do sistema${F}"
sleep 2
AtualizandoRelogioSistema
clear

# Criando o arquivo vconsole.conf
echo -e "${S} ${C}Criando o arquivo vconsole.conf${F}"
sleep 2
CriandoArquivoVconsoleConf
clear

# Criando o hostname
echo -e "${S} ${C}Criando o hostname${F}"
sleep 2
CriandoHostname
clear

# Configurando o hosts
echo -e "${S} ${C}Configurando o arquivo hosts${F}"
sleep 2
ConfigurandoHosts
clear

# Criando senha de root
echo -e "${S} ${C}Criando a senha do root${F}"
sleep 2
CriandoSenhaRoot
clear

# Baixando o Gerenciador de boot 
echo -e "${S} ${C}Baixando o Gerenciador de boot${F}"
sleep 2
GerenciadorDeBoot
clear

# Instalando o grub
echo -e "${S} ${C}Instalando o grub${F}"
sleep 2
InstalandoGrub
clear

# Iniciando o NetworkManager
echo -e "${S} ${C}Iniciando o NetworkManager${F}"
sleep 2
NetworkManager
clear

# Adicionando um usuario
echo -e "${S} ${C}Adicionando o usuário${F}"
sleep 2
AdicionandoUsuario
clear

# Criando senha de usuario
echo -e "${S} ${C}Adicionando a senha do usuário${F}"
sleep 2
AdicionandoSenhaUsuario
clear

# Adicionando user no grupo sudoers
echo -e "${S} ${C}Adicionando o usuário no grupo sudoers${F}"
sleep 2
ConfigurandoSudoers
clear

# Colorindo a sída do pacman 
echo -e "${S} ${C}Colorindo a saída do pacman${F}"
sleep 2
ColorindoSaidaPacman
clear

# Configurando o Fstab
echo -e "${S} ${C}Configurando o Fstab${F}"
sleep 2
ConfigurandoFstab
clear

# Reiniciando
echo -e "${S} ${C}Reinicie o sistema para continuar com a terceira parte!${F}"
sleep 2


