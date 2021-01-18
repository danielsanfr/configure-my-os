#!/bin/bash

echo "Instaling make..."
sudo pacman -S --noconfirm --needed make yay

echo "Update and upgrade the system..."
sudo pacman -Syu
