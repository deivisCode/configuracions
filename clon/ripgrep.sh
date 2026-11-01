#!/usr/bin/bash

if [ ! -d './ripgrep/.git' ] ; then
    mkdir ripgrep
    git clone --depth=1 https://github.com/BurntSushi/ripgrep
fi

cd ripgrep || exit
git switch master && git pull || echo "Non se puido actualizar o repo"

[ -x $HOME/.cargo/bin/cargo ] \
    && cargo build --release --features 'pcre2' \
    || echo "Algo fallou ao instalar"

mv -i ./target/release/rg $HOME/.local/bin \
    && echo "Moveuse correctamente a .local/bin/" \
    || echo "Algo fallou ao mover"
