#!/bin/bash

echo "Instaling make..."
sudo pacman -S --noconfirm make

echo "Update and upgrade the system..."
sudo pacman -Syu
