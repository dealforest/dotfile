#!/bin/sh


for file in .zshrc .zshrc.mine .vimrc .vim .gvimrc .screenrc .inputrc .module-starter .gitignore .toprc
do
    rm -v ~/$file
    ln -sv $PWD/$file ~/$file
done


