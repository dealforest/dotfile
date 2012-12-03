#!/bin/sh


for file in .vimrc .vim .gvimrc .screenrc .inputrc .module-starter .gitignore .toprc .sqliterc .proverc .gdbinit .gitconfig .railsrc .gemrc .tigrc .tmux.conf .pryrc
do
    rm -v ~/$file
    ln -sv $PWD/$file ~/$file
done

for file in zshrc zshenv
do
    rm -v ~/.$file
    ln -sv $PWD/zsh.d/$file ~/.$file
done
