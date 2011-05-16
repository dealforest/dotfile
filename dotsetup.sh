#!/bin/sh


for file in .zshrc .zshrc.mine .vimrc .vim .gvimrc .screenrc .inputrc .module-starter .gitignore .toprc .sqliterc
do
    rm -v ~/$file
    ln -sv $PWD/$file ~/$file
done


