#!/bin/sh


for file in .zshrc .zshrc.mine .vimrc .vim .screenrc .inputrc .module-starter
do
    rm -v ~/$file
    ln -sv $PWD/$file ~/$file
done


