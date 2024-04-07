### **1. Salvar todos os comandos**

O **comando script** armazena tudo que é digitado no terminal em um arquivo de log que pode ser lido, posteriormente, pelo usuário. Para iniciar uma gravação, com registro de tempo de execução para cada comando, **inicie uma sessão na ferramenta script dessa maneira**:

script – -timing=tempo.txt script.log

![script](https://www.linuxdescomplicado.com.br/wp-content/webpc-passthru.php?src=https://www.linuxdescomplicado.com.br/wp-content/uploads/2017/03/script.gif&nocache=1)

Onde,

**– -timing:** representa o parâmetro que envia para arquivo o intervalo de tempo entre cada execução de comando. Importante para uma posterior reprodução dos comandos executados;
**script.log:** arquivo de log contendo os comandos executados e resultados (saída) obtidos;

Para fechar a sessão, depois de ter digitado todos os comandos, execute o comando exit:

exit

Veja o conteúdo do arquivo de log e verifique que o todos os comandos digitados, no período em que a sessão esteve aberta, foram salvos!

### **2. Reproduzir todos os comandos**

O **comando scriptreplay** reproduz as informações contidas no arquivo de log gerado pelo **comando script** (no caso o script.log). Além disso, ele ler o arquivo de temporização para reproduzir, fielmente, cada comando executado:

scriptreplay – -timing=tempo.txt script.log