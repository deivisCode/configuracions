#!/usr/bin/bash

while read input; do
    if [ -n "$input" ]; then
        resultados=$(
        echo "$input" | \
            hunspell -d "$HOME/.deivis_datos/recursos/codigo/diccionarios/gl" | \
                grep "^&"       | \
                cut -d ":" -f 2 | \
                sed 's/,//g'    | \
                xargs echo      | \
                sed 's/ /\n/g'
    )
    fi
done < "${1:-/dev/stdin}"

[ -n "$resultados" ] && echo -e "$resultados"
