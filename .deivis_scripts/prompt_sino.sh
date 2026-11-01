#!/usr/bin/bash
# script para aceptar cousas cunha prompt tipo SI/NO usando wmenu.
# por exemplo:
# ./prompt "Apagar o ordenador?" "shutdown now"

[ $(echo -e "No\nSi" | ~/.deivis_scripts/menu.sh "$1") == "Si" ] && $2
