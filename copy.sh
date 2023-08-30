#!/bin/bash

rm -rf config &&
cp ~/.config ./config -rf &&
rm -rf chadwm/.git nvim/.git cef_user_data  autostart font-manager fontconfig fontforge gh GIMP github copilot gtk* inkspace JetBrains Kitware libreoffice mpv pavucontrol-qt pulse TabNine Thunar user-dirs* xfce4 yay

