#!/usr/bin/bash

mkdir texlive_temp
cd texlive_temp
wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
zcat < install-tl-unx.tar.gz | tar xf - # note final - on that command line
rm install-tl-unx.tar.gz
cd install-tl-* || echo "algo foi mal"

sudo perl ./install-tl --no-interaction

# limpar
# rm -rf /usr/local/texlive/2025
# rm -rf ~/.texlive2025
