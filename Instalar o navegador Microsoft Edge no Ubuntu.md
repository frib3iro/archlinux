### Instalar o navegador Microsoft Edge no Ubuntu

Passo 1. Abra um terminal (use as teclas CTRL + ALT + T);
Passo 2. Se ainda não tiver, adicione o repositório do programa com estes comandos ou use esse [tutorial](https://www.edivaldobrito.com.br/adicionar-repositorios-no-ubuntu/);

```
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
sudo rm microsoft.gpg
```

Passo 3. Atualize o gerenciador de pacotes com o comando:

```
sudo apt update
```

Passo 4. Agora use o comando abaixo para instalar o programa;

```
sudo apt install microsoft-edge-dev
```

CONTINUA APÓS A PUBLICIDADE

Pronto! Agora, você pode iniciar o programa no menu Aplicativos/Dash/Atividades ou qualquer outro lançador de aplicativos da sua distro, ou digite `microsoft` ou em um terminal, seguido da tecla TAB.

### Desinstalando

Para desinstalar o navegador Microsoft Edge, faça o seguinte:

Passo 1. Abra um terminal;
Passo 2. Desinstale o programa, usando os comandos abaixo;

```
sudo apt remove microsoft-edge-* --auto-remove
```