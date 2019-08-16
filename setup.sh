#!/bin/bash

# neovim configuration file
NEOVIM_CNF_FILE=~/.config/nvim/init.vim
YES=false

# Install Neovim with Python support
if ! type nvim > /dev/null; then
  sudo add-apt-repository -y ppa:neovim-ppa/stable
  sudo apt-get update
  sudo apt-get -y install neovim python-dev python-pip python3-dev python3-pip
  sudo pip install --upgrade pip
  sudo pip3 install --upgrade pip3
  sudo pip install --user neovim
  sudo pip3 install --user neovim
fi

# Install Plug plugin manager
if [ ! -e "~/.local/share/nvim/site/autoload/plug.vim" ]; then
  if ! type curl > /dev/null; then
    sudo apt-get -y install curl
  fi

   curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Setup the configuration
for arg in "$@"
do
  if [ "$arg" == "--yes" ] || [ "$arg" == "-y" ]; then
    echo "Replacing the installed configuration"
    YES=true
  fi
  done


if [ "$YES" == false ] && [ -f "$FILE" ]; then
  echo "$FILE already exist, should we replace it ? (y/N)"
    read resp1

    if [ "$resp1" != y ]; then
      echo "Ok, bye!"
      exit
    fi
      
  rm -rf $NEOVIM_CNF_FILE
fi

cp init.vim $NEOVIM_CNF_FILE
