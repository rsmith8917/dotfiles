#! /bin/bash

DOTFILES=(.zshrc)

for dotfile in $(echo ${DOTFILES[*]});
do
    cp ~/repos/dotfiles/$(echo $dotfile) ~/$(echo $dotfile)
done
