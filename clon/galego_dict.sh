#!/usr/bin/bash

if [ ! -d './hunspell-gl/.git' ] ; then
    mkdir hunspell-gl
    git clone --depth=1 https://gitlab.com/trasno/hunspell-gl
fi

cd hunspell-gl || exit
git switch master && git pull || echo "Non se puido actualizar o repo"

# Fai falta usar python para xerar os arquivos *.dic e *.aff
python3 -m venv venv && source venv/bin/activate && pip install wheel PyICU SCons

# Esto e pa escoller qué fontes usar para os dicionarios
TODO=$(ls src | grep -v / | xargs echo | sed 's/ /,/g')

# E agora limpamos e rulamos con todo
scons -c && scons metadata=strip aff=$TODO dic=$TODO rep=$TODO

deactivate

cd build || exit

# Esto é opcional. A vim non lle valen os *.dic e *.aff que se xeran deste
# modo, asique hai que obter unha lista de palabras con hunspell-reader
# (instalado con npm). Mirar alternativas como
# https://github.com/hunspell/hunspell/blob/master/src/tools/unmunch.cxx
# https://github.com/hunspell/hunspell/blob/master/src/tools/unmunch.h
#
# wget -O ./dic/es_ES.aff "https://raw.githubusercontent.com/sbosio/rla-es/master/source-code/hispalabras-0.1/hispalabras/es_ES.aff"
# wget -O ./dic/es_ES.dic "https://raw.githubusercontent.com/sbosio/rla-es/master/source-code/hispalabras-0.1/hispalabras/es_ES.dic"
# wget -O ./dic/unmunch.cxx "https://raw.githubusercontent.com/hunspell/hunspell/master/src/tools/unmunch.cxx"
# wget -O ./dic/unmunch.h "https://raw.githubusercontent.com/hunspell/hunspell/master/src/tools/unmunch.h"
# g++ -o ./dic/unmunch ./dic/unmunch.cxx
# ./dic/unmunch ./dic/es_ES.dic ./dic/es_ES.aff 2> /dev/null > ./dic/es_ES.txt.bk
# sort ./dic/es_ES.txt.bk > ./dic/es_ES.txt # Opcional
# rm ./dic/es_ES.txt.bk # Opcional
#
# Ou directamente ca ferramenta de husnpell, unmunch, sin compilar nada
hunspell-reader words --unique --progress --forbidden gl.dic -o palabras_gl.txt

cp gl.* "$HOME/.deivis_datos/recursos/codigo/diccionarios/" && \
    echo "Movéronse correctamente os dicionarios" || \
    echo "Non se puideron mover os dicoinarios"

cp palabras_gl.txt "$HOME/.deivis_datos/recursos/codigo/diccionarios/" && \
    echo "Moveuse correctamente o arquivo de palabras" || \
    echo "Non se puido mover o arquivo de palabras"

# Ollo, finalmente hai que usar nvim con :mkspell gl palabras_gl.txt pa xerar
# a spellfile. E esta debe poñerse na runtimepath en spell/
