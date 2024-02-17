#!/bin/bash

# Overwrite vim config
cp .vimrc ~/.vimrc

# Install Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install the plugins
vim +PlugInstall +qall
vim +PlugUpdate +qall

