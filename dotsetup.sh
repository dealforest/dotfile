#!/bin/sh


for file in .zshrc .zshrc.mine .vimrc .vim .screenrc .ctags .synergy.conf .gitconfig .gitignore .inputrc
do
    rm -v ~/$file
    ln -sv $PWD/$file ~/$file
done


