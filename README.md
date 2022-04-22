# archlinux

# Adicionando ao github

git add .

git commit -m ""

git push -u origin main

git remote set-url origin git@github.com:frib3iro/archlinux.git

# Se você tiver um clone local, poderá atualizá-lo executando os comandos a seguir.

git branch -m master main

git fetch origin

git branch -u origin/main main

git remote set-head origin -a
