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

# install vim solarized theme
DIR=`pwd`
cd ~/.vim/bundle
if [ ! -d vim-colors-solarized ]; then
	git clone git://github.com/altercation/vim-colors-solarized.git
	cd vim-colors-solarized/colors;
	cp solarized.vim ~/.vim/colors;
fi
cd $DIR
cp _vimrc ~/.vimrc

echo "Make sure to update your terminal colorscheme aswell!"
