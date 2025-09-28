#!/bin/bash
sudo pacman -Syu        # update base system
yay -S --needed - < pkglist.txt
