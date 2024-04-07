## Como instalar o YAY no Arch Linux

Para instalar o AUR Helper YAY no Arch Linux e derivados, você deve fazer o seguinte:

Passo 1. Abra um terminal;
Passo 2. Certifique-se de que seu sistema tem instalado o git e os pacotes da linguagem Go;

```
sudo pacman -S git go
```

Passo 3. Use o comando abaixo para baixar o código fonte do YAY;

```
git clone https://aur.archlinux.org/yay.git
```

Passo 4. Em seguida, acesse a pasta criada;

```
cd yay
```

Passo 5. Finalmente, use o comando abaixo para compilar e instalar o programa;

```
makepkg -si
```