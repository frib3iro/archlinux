## Melhorando a temperatura em Notebooks

Para evitar superaquecimento no meu notebook Dell 7560, instalei o thermald que se trata de um firmware da Intel para auxiliar no controle das fans do notebook, evitando assim o superaquecimento da máquina. E pra isso usei os seguintes comandos para instalar e habilitar a inicialização automatica pelo systemd.

```
sudo pacman -S thermald

sudo thermald --systemd
```

```
sudo nano /etc/pacman.conf
```

```
#Color                  (remova o #)
#ParallelDownloads = 5 (remova o # e mude de 5 para 10)
```

Para habilitar o Bluetooth no seu sistema (pois é bem melhor usar fones de ouvido sem fio por exemplo), pode fazer da seguinte forma:

```
sudo systemctl start bluetooth.service - -now (dessa maneira não precisa reiniciar o sistema)
```