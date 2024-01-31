#!/bin/bash

echo "Enable AUR..."
sudo sed -i '/EnableAUR/s/^#//g' /etc/pamac.conf

echo "Instaling make..."
sudo pacman -S --noconfirm --needed make yay

echo "Update and upgrade the system..."
sudo pacman -Syu
