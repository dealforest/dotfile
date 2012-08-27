#!/bin/sh


for file in .zshrc .zshrc.mine .vimrc .vim .gvimrc .screenrc .inputrc .module-starter .gitignore .toprc .sqliterc .proverc .gdbinit .gitconfig .railsrc .gemrc .tigrc .tmux.conf
do
    rm -v ~/$file
    ln -sv $PWD/$file ~/$file
done


