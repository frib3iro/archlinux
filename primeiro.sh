#!/usr/bin/env bash

## Import das variaveis globais e funções 
source variaveis.sh
source funcoes.sh

# Tela de boas vindas
clear
echo -e "${seta} ${ciano}Bem vindo a instalação do Arch Linux${fim}"
sleep 2s
clear

# Definindo layout do teclado
echo -e "${seta} ${ciano}Definindo o layout do teclado${fim}"
sleep 2s
DefinindoLayoutTeclado
clear

# Atualizando o relógio do sistema
echo -e "${seta} ${ciano}Atualizando o relógio do sistema${fim}"
sleep 2s
AtualizandoRelogioSistema
clear

# Listando os discos
echo -e "${seta} ${ciano}Listando os discos${fim}"
ListandoDiscos

# Informando o nome do seu disco
echo -en "${seta} ${ciano}Informe o nome do seu disco: ${fim}"; read disco
disco=/dev/${disco}
clear

echo -e "${seta} ${ciano}Digite${fim} ${vermelho}[ 1 ]${fim} ${ciano}para máquina virtual${fim}${fim}"
echo -e "${seta} ${ciano}Digite${fim} ${vermelho}[ 2 ]${fim} ${ciano}para máquina real${fim}"
echo -en "\n${seta} ${amarelo}Digite sua resposta:${fim} "
read resposta
clear

if [ "$resposta" -eq 1 ]; then
    echo -e "${seta} ${ciano}Iniciando particionamento na máquina virtual${fim}"
    sleep 2s
    MaquinaVirtual
    clear
elif [ "$resposta" -eq 2 ]; then
    echo -e "${seta} ${ciano}Iniciando particionamento na máquina real${fim}"
    sleep 2s
    MaquinaReal
    clear
else
    echo -e "${seta} ${vermelho}Resposta inválida!${fim}"
    exit 1
fi

# Formatando partições
echo -e "${seta} ${ciano}Formatando as partições${fim}"
sleep 2s
FormatandoParticoes
clear

# Montando partições
echo -e "${seta} ${ciano}Montando as partições${fim}"
sleep 2s
MontandoParticoes
clear

# Listando partições
echo -e "${seta} ${ciano}Conferindo as partições${fim}"
ConferindoParticoes
sleep 3s
clear

# Instalando os pacotes base
echo -e "${seta} ${ciano}Instalando os pacotes base${fim}"
sleep 2s
InstalandoPacotesBase
clear

# Gerando o fstab
echo -e "${seta} ${ciano}Gerando o fstab${fim}"
sleep 2s
GerandoFstab
clear

# Copiando o scripts para /mnt
echo -e "${seta} ${ciano}Copiando o scripts para /mnt${fim}"
sleep 2s
CopiandoScripts
clear

# Iniciando arch-chroot
echo -e "${seta} ${ciano}Iniciando arch-chroot${fim}"
sleep 2s
IniciandoArchChroot

