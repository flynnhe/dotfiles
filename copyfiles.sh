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

DIR=`pwd`;

# install c++ advanced vim highlighting
#git clone https://github.com/octol/vim-cpp-enhanced-highlight.git /tmp/vim-cpp-enhanced-highlight
#mkdir -p ~/.vim/after/syntax/
#mv /tmp/vim-cpp-enhanced-highlight/after/syntax/cpp.vim ~/.vim/after/syntax/cpp.vim
#rm -rf /tmp/vim-cpp-enhanced-highlight

# install monokai gnome theme
if [ ! -d "gnome-terminal-colors-monokai" ]; then
  git clone git://github.com/pricco/gnome-terminal-colors-monokai.git;
fi
cd gnome-terminal-colors-monokai;
apt-get install dconf-cli;
./install.sh;
cd $DIR;

# install monokai vim colorscheme
if [ ! -d "vim-monokai" ]; then
  git clone https://github.com/sickill/vim-monokai.git;
fi
cd vim-monokai/colors;
cp monokai.vim ~/.vim/colors;
cd $DIR;

cp _vimrc ~/.vimrc
