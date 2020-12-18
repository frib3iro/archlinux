#!/usr/bin/env bash
#----------------------------------------------------------------------
# Script    : primeiro.sh
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

# Tela de boas vindas
clear
echo -e "${S} ${G}Bem vindo a instalação do Arch Linux no modo UEFI${F}"
sleep 2
clear

# Definindo o idioma
echo -e "${S} ${C}Definindo o idioma${F}"
sleep 2
DefinirIdioma
clear

# Definindo layout do teclado
echo -e "${S} ${C}Definindo o layout do teclado${F}"
sleep 2
DefinindoLayoutTeclado
clear

# Atualizando o relógio do sistema
echo -e "${S} ${C}Atualizando o relógio do sistema${F}"
sleep 2
AtualizandoRelogioSistema
clear

# Listando os discos
echo -e "${S} ${C}Listando os discos${F}"
ListandoDiscos

# Informando o nome do seu disco
echo -en "${S} ${Y}Informe o nome do seu disco: ${F}"
read disco
disco=/dev/${disco}
clear

echo -e "${S} ${C}Digite${F} ${Y}[ 1 ]${F} ${C}para instalar na máquina real${F}"
echo -e "${S} ${C}Digite${F} ${Y}[ 2 ]${F} ${C}para instalar na máquina virtual${F}"
echo
echo -en "${S} ${Y}Digite a opção desejada: ${F}"
read opcao
case $opcao in
    1) clear
        echo -e "${S} ${C}O sistema será instalado na maquina virtual${F}"
        MaquinaReal
        ;;
    2) clear
        echo -e "${S} ${C}O sistema será instalado na maquina real${F}"
        MaquinaVirtual
        ;;
    *) clear
        echo "${S} ${R}Resposta inválida!${F}"
        exit 0
        ;;
esac

# Formatando partições
echo -e "${S} ${C}Formatando as partições${F}"
sleep 2
FormatandoParticoes
clear

# Montando partições
echo -e "${S} ${C}Montando as partições${F}"
sleep 2
MontandoParticoes
clear

# Listando partições
echo -e "${S} ${C}Conferindo as partições${F}"
ConferindoParticoes
sleep 3s
clear

# Instalando os pacotes base
echo -e "${S} ${C}Instalando os pacotes base${F}"
sleep 2
InstalandoPacotesBase
clear

# Gerando o fstab
echo -e "${S} ${C}Gerando o fstab${F}"
sleep 2
GerandoFstab
clear

# Copiando o scripts para /mnt
echo -e "${S} ${C}Copiando os scripts para /mnt${F}"
sleep 2
CopiandoScripts
clear

# Iniciando arch-chroot
echo -e "${S} ${C}Iniciando arch-chroot${F}"
sleep 2
IniciandoArchChroot

