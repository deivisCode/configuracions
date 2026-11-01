#!/usr/bin/bash

echo -e "\nATENCION:\nCompilar qsv con todas as features leva tempo e recursos (~20min)\n"
while true; do
    read -p "Instalar qsv? " yn
    case $yn in
        [Yy]* ) echo "Tu mismo";
            [ -x $HOME/.cargo/bin/cargo ]  \
                && cargo install qsv --locked -F feature_capable,mimalloc,apply,fetch,foreach,lens,prompt,to,ui,geocode,self_update,luau,python   \
                || echo "Algo fallou ao instalar"

            mv $HOME/.cargo/bin/qsv $HOME/.local/bin/  \
                && echo "Moveuse correctamente a .local/bin/"  \
                || echo "Algo fallou ao mover"
            break;;
        [Nn]* ) echo "Adeus"; break ;;
        * ) echo "Yes or noes.";;
    esac
done
