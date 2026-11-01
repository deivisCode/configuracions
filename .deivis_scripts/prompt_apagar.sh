#!/usr/bin/bash

eleccions="APAGAR\nSUSPENDER"

escolla=$(echo -e "$eleccions" | ~/.deivis_scripts/menu.sh "QUE FAS:")

case "$escolla" in
    APAGAR) ~/.deivis_scripts/prompt_sino.sh "$escolla?" "shutdown now";;
    SUSPENDER) ~/.deivis_scripts/prompt_sino.sh "$escolla?" "systemctl suspend";;
esac
