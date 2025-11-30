#!/bin/bash
sudo pacman -Syu        # update base system
yay -S --needed - < ./common-packages.txt
