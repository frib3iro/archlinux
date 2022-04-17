# Funções --------------------------------------------------------

# Adicionando a senha de root
senharoot(){
    echo -en "${S} ${B}Digite uma senha para o root: ${F}"
    read -s passroot1; echo
    echo -en "${S} ${B}Repita a senha: ${F}"
    read -s passroot2; echo
    if [[ $passroot1 -eq $passroot2 ]]
    then
	    echo "root:$passroot1" | chpasswd
    else
        echo -e "${S} ${R}As senhas nao correspondem!${F}"
        senharoot
    fi
}

# Adicionando um usuario
usuario(){
    echo -en "${S} ${B}Digite um nome para o usuário: ${F}"
    read usuario
    useradd -m -g users -G wheel $usuario

}

# Criando a senha de usuario
senhauser(){
    echo -en "${S} ${B}Digite uma senha para o $usuario: ${F}"
    read -s passuser1; echo
    echo -en "${S} ${B}Repita a senha: ${F}"
    read -s passuser2; echo
    if [[ $passuser1 -eq $passuser2 ]]
    then
	    echo "$usuario:$passuser1" | chpasswd
    else
        echo -e "${S} ${R}As senhas nao correspondem!${F}"
        senhauser
    fi
}

# Instalando o openssh
installssh(){
    echo -e "${S} ${B}Instalando o openssh${F}"
    sleep 2s
    sudo pacman -S openssh --noconfirm
    clear
    echo -e "${S} ${B}Abrindo a porta 22${F}"
    sleep 2s
    sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
    clear
    echo -e "${S} ${B}Reiniciando o serviço sshd${F}"
    sleep 2s
    systemctl restart sshd
    clear
    echo -e "${S} ${B}Mostrando o ip${F}"
    echo
    echo -e "${S} ${B}Copie o ip para fazer a conexão entre as máquinas${F}"
    ip -br -c a
    echo -e "${S} ${G}Para se conectar digite${F} ${R}[${F}${B}ssh usuario@IP${F}${R}]${F}"
}
