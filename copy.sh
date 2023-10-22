#!/bin/bash

rm -rf config
cp ~/.config ./config -rf
cd config || exit
rm mimeapps.list
rm -rf chadwm/.git nvim/.git cef_user_data autostart font-manager fontconfig fontforge gh GIMP github-copilot gtk-2.0 gtk-3.0 inkscape JetBrains Kitware libreoffice mpv pavucontrol-qt pulse TabNine Thunar user-dirs* xfce4 yay QtProject.conf dconf st/.git st/.gitignore Unknown\ Organization browsh discordo gh-dash jgit window-geometry.conf neomutt mutt/accounts/* zathura yarn whatscli cppman asciinema

cd ..
