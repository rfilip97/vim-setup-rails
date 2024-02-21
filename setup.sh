#!/bin/bash

# Remove existing .vimrc if it exists
if [ -f ~/.vimrc ] || [ -L ~/.vimrc ]; then
  echo "Removing existing .vimrc"
  rm ~/.vimrc
fi

# Create a symlink to .vimrc in the current directory
echo "Creating a symlink to .vimrc in the current directory"
ln -s "$(pwd)/.vimrc" ~/.vimrc
chmod -x ~/.vimrc

# Ensure clipboard support
if ! vim --version | grep -q '+clipboard'; then
  echo "Vim clipboard support not detected. Installing vim-gtk3..."
  sudo apt update
  sudo apt install -y vim-gtk3
fi

# Install Plug
if [ ! -f ~/.vim/autoload/plug.vim ]; then
  echo "Vim Plug is not installed. Installing..."
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install the plugins
vim +PlugInstall +qall
vim +PlugUpdate +qall

