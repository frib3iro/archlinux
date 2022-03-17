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
