#!/usr/bin/bash

eleccions="Portatil\nHDMI\nAmbos"

escolla=$(echo -e "$eleccions" | ~/.deivis_scripts/menu.sh "PANTALLA:")

case "$escolla" in
    Portatil) swaymsg output HDMI-A-1 disable && swaymsg output eDP-1 enable;;
    HDMI) swaymsg output HDMI-A-1 enable && swaymsg output eDP-1 disable;;
    Ambos) swaymsg output HDMI-A-1 enable && swaymsg output eDP-1 enable;;
esac
