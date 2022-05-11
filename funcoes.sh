# Funções --------------------------------------------------------

# Adicionando a senha de root
senharoot(){
    echo -en "${s} ${b}Digite a senha do root: ${f}"
    read -es passroot1; echo
    echo -en "${s} ${b}Repita a senha: ${f}"
    read -es passroot2; echo
    if [[ $passroot1 -eq $passroot2 ]]
    then
	    echo "root:$passroot1" | chpasswd
    else
        echo -e "${s} ${r}As senhas nao correspondem!${f}"
        senharoot
    fi
}

# Criando a senha de usuario
usuario(){
    echo -en "${s} ${b}Digite um nome para o usuário: ${f}"
    read -e usuario
    useradd -m -g users -G wheel $usuario
    echo -en "${s} ${b}Digite uma senha para o $usuario: ${f}"
    read -es passuser1; echo
    echo -en "${s} ${b}Repita a senha: ${f}"
    read -es passuser2; echo
    if [[ $passuser1 -eq $passuser2 ]]
    then
	    echo "$usuario:$passuser1" | chpasswd
    else
        echo -e "${s} ${r}As senhas nao correspondem!${f}"
        senhauser
    fi
}

# Instalando o openssh
installssh(){
    echo -e "${s} ${b}Instalando o openssh...${f}"
    sleep 2s
    sudo pacman -S openssh --noconfirm
    clear
    echo -e "${s} ${b}Abrindo a porta 22...${f}"
    sleep 2s
    sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
    clear
    echo -e "${s} ${b}Reiniciando o serviço sshd...${f}"
    sleep 2s
    systemctl restart sshd
    clear
    echo -e "${s} ${b}Mostrando o ip...${f}"
    echo
    echo -e "${s} ${b}Copie o ip para fazer a conexão entre as máquinas...${f}"
    ip -br -c a
    echo -e "${s} ${G}Para se conectar digite${f} ${r}[${f}${b}ssh usuario@IP${f}${r}]${f}"
}
