#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

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

# install smyck vim and mac terminal colorscheme
if [ ! -d "Smyck-Color-Scheme" ]; then
  git clone https://github.com/hukl/Smyck-Color-Scheme.git;
fi
open Smyck-Color-Scheme/Smyck.terminal;
cp Smyck-Color-Scheme/smyck.vim ~/.vim/colors;
cp _vimrc ~/.vimrc
