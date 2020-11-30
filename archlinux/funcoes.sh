#!/usr/bin/env bash

## Funções ------------------------------------------------------

# Para a maquina_virtual
MaquinaVirtual(){
    (echo g; echo n; echo ""; echo ""; echo +512M; echo t; echo 1; echo n; echo ""; echo ""; echo ""; echo w) | fdisk ${disco}
}

# Para a máquina real
MaquinaReal(){
    (echo d; echo ""; echo d; echo ""; echo g; echo n; echo ""; echo ""; echo +512M; echo t; echo 1; echo n; echo ""; echo ""; echo ""; echo w) | fdisk ${disco}
}

ArquivoSwap(){
    dd if=/dev/zero of=/swapfile bs=1M count=4096 status=progress
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo "/swapfile none swap defaults 0 0" >> /etc/fstab
}

FonteTerminal(){
    setfont ter-132n
}

# Definindo layout do teclado
DefinindoLayoutTeclado(){
    loadkeys br-abnt2
}

# Listando os discos
ListandoDiscos(){
    lsblk -l | grep disk
}

# Formatando partições
FormatandoParticoes(){
    mkfs.fat -F32 ${disco}1
    mkfs.ext4 ${disco}2
}

# Montando partições
MontandoParticoes(){
    mount ${disco}2 /mnt
    mkdir -p /mnt/boot/efi
    mount ${disco}1 /mnt/boot/efi
}

# Listando partições
ConferindoParticoes(){
    lsblk ${disco}
}

# Instalando os pacotes base
InstalandoPacotesBase(){
    pacstrap /mnt base base-devel linux linux-firmware vim
}

# Gerando o fstab
GerandoFstab(){
    genfstab -U /mnt >> /mnt/etc/fstab
}

# Copiando o script archinstall-02.sh para /mnt
CopiandoScript(){
    cp install-01.sh install-02.sh variaveis.sh funcoes.sh /mnt
}

# Iniciando arch-chroot
IniciandoArchChroot(){
    arch-chroot /mnt ./install-02.sh
}
# Ajustando o fuso horário
FusoHorario(){
    ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
}

# Executando hwclock
ExecutandoHwclock(){
    hwclock --systohc --utc
}

# Definir o idioma do ambiente live
DefinirIdioma(){
    sed -i 's/en_US ISO-8859-1/#en_US ISO-8859-1/' /etc/locale.gen
    sed -i 's/en_US.UTF-8/#en_US.UTF-8/' /etc/locale.gen
    sed -i 's/#pt_BR.UTF-8/pt_BR.UTF-8/' /etc/locale.gen
    sed -i 's/#pt_BR ISO-8859-1/pt_BR ISO-8859-1/' /etc/locale.gen
    locale-gen
}

# Criando o arquivo locale.conf
CriandoLocaleConf(){
    echo LANG=pt_BR.UTF-8 > /etc/locale.conf
}

# Exportando a variável LANG
EportandoVariavelLang(){
    export LANG=pt_BR.UTF-8
}

# Atualizando o relógio do sistema
AtualizandoRelogioSistema(){
    timedatectl set-ntp true
}

# Criando o arquivo vconsole.conf
CriandoArquivoVconsoleConf(){
    echo KEYMAP=br-abnt2 > /etc/vconsole.conf
}

# Criando o hostname
CriandoHostname(){
    echo archlinux > /etc/hostname
}

# Configurando o hosts
ConfigurandoHosts(){
    cat >> '/etc/hosts' << EOF
127.0.0.1 localhost.localdomain localhost
::1 localhost.localdomain localhost
127.0.1.1 archlinux.localdomain archlinux
EOF
}

# Criando senha de root
CriandoSenhaRoot(){
    echo "root:$pass_root" | chpasswd
}

# Baixando o Gerenciador de boot
GerenciadorDeBoot(){
    pacman -S dialog dosfstools intel-ucode efibootmgr git grub linux-headers mtools networkmanager network-manager-applet vim wget xorg --noconfirm
}

# Instalando o grub
InstalandoGrub(){
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
    grub-mkconfig -o /boot/grub/grub.cfg
}

# Iniciando o NetworkManager
NetworkManager(){
    systemctl enable NetworkManager
    systemctl start NetworkManager
}

# Adicionando um usuario
AdicionandoUsuario(){
    useradd -m -g users -G wheel fabio
}

# Criando senha de usuario
AdicionandoSenhaUsuario(){
    echo "$user:$pass_user" | chpasswd
}

# Adicionando user no grupo sudoers
ConfigurandoSudoers(){
    sed -i '/root ALL=(ALL) ALL/a fabio ALL=(ALL) ALL' /etc/sudoers
}

# Colorindo a sída do pacman
ColorindoSaidaPacman(){
    sed -i 's/#Color/Color/' /etc/pacman.conf
}

# Definindo lauout do teclado para pt-br
DefinindoLayoutTecladoXorg(){
    cat >> '/etc/X11/xorg.conf.d/10-keyboard.conf' << EOF
Section "InputClass"
Identifier "keyboard default"
MatchIsKeyboard "yes"
Option "XkbLayout" "br"
Option "XkbVariant" "abnt2"
fimSection
EOF
}

# Configurando o Fstab
ConfigurandoFstab(){
    cat >> '/etc/fstab' << EOF

# /dev/sdc
UUID=6A5615215614F015 /mnt ntfs defaults 0 1
EOF
}

