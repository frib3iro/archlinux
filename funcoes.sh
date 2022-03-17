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
        clear
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
    echo -en "${S} ${B}Digite uma senha: ${F}"
    read -s passuser1; echo
    echo -en "${S} ${B}Repita a senha: ${F}"
    read -s passuser2; echo
    if [[ $passuser1 -eq $passuser2 ]]
    then
	echo "$usuario:$passuser1" | chpasswd
    else
        clear
        echo -e "${S} ${R}As senhas nao correspondem!${F}"
        senhauser
    fi   

# Definindo lauout do teclado para pt-br
teclado(){
	echo
	echo -e "${S} ${C}Definindo o layout do teclado no xorg${F}"
	cat >> '/etc/X11/xorg.conf.d/10-keyboard.conf' << EOF
	Section "InputClass"
	Identifier "keyboard default"
	MatchIsKeyboard "yes"
	Option "XkbLayout" "br"
	Option "XkbVariant" "abnt2"
	fimSection
	EOF
}

