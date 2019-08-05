#!/bin/bash
# neovim configuration file
FILE=~/.config/nvim/init.vim
YES=false

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
  fi

rm -rf $FILE
ln init.vim $FILE
