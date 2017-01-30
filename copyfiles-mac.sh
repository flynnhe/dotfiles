#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

install_solarized_vim=false

# copy local bash settings to home directory
[ -e ~/.local.bash ] && mv ~/.local.bash ~/.local.bash.bak;
cp _local.bash ~/.local.bash

# make sure local bash settings are called on shell startup
str="[[ -s ${HOME}/.local.bash ]] && source ${HOME}/.local.bash # include my own (if I can't mess with bashrc)"
if [ -e ~/.bash_profile ]; then
  if grep -q "$str" ~/.bash_profile
  then
    echo "Already using your bash settings"
  else
    echo $str >> ~/.bash_profile
  fi
fi

if [ -e ~/.profile ]; then
  if grep -q "$str" ~/.profile
  then
    echo "Already using your bash settings"
  else
    echo "$str" >> ~/.profile
  fi
fi

DIR=`pwd`
if [ ! -d "~/.vim" ]; then
	mkdir -p ~/.vim/colors;
fi

# install monokai terminal
if [ ! -d "monokai.terminal" ]; then
  git clone git://github.com/stephenway/monokai.terminal.git;
fi
cd monokai.terminal;
open Monokai.terminal;

# install monokai vim
if [ ! -d "vim-monokai" ]; then
  git clone https://github.com/sickill/vim-monokai.git;
fi
cd vim-monokai/colors;
cp monokai.vim ~/.vim/colors

# install vim solarized theme
if [ $install_solarized_vim ];
then
  cd ~/.vim/colors
  if [ ! -d vim-colors-solarized ]; then
    git clone git://github.com/altercation/vim-colors-solarized.git
    cd vim-colors-solarized/colors;
    cp solarized.vim ~/.vim/colors;
  fi
  cd $DIR
  cp _vimrc ~/.vimrc

  echo "Make sure to update your terminal colorscheme aswell!"
fi
