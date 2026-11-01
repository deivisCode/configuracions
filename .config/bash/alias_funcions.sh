# ALIASES -----------------------------------------------------------

alias c='clear'
alias ..='cd ..'
alias n='nvim'
alias q='exit'
alias p='python3'
alias loc='which'
alias sai='sudo apt install'
alias configura='/usr/bin/git --git-dir=$HOME/.deivis_cfg/ --work-tree=$HOME'
alias exp='nautilus $PWD'
# alias z='zathura'
alias sus='sudo apt update && echo -e "\n" && apt list --upgradable'
alias probas="cd /home/david/.deivis_datos/codigos/.probas/"
alias uni="cd /home/david/.deivis_datos/proxectos/uni/"
alias daf="cd /home/david/.deivis_datos/proxectos/uni/DAF/"
alias lingua="cd /home/david/.deivis_datos/proxectos/uni/lingua/"
alias dic="cd /home/david/.deivis_datos/proxectos/uni/lingua/dicionario/repo/"
alias revista="cd /home/david/.deivis_datos/proxectos/uni/revista/"
alias apuntes="cd /home/david/.deivis_datos/proxectos/uni/apuntes/"
alias gti='echo "Escribe ben" && git'
alias l='eza --all --sort=extension --icons=always --group-directories-first'
alias ll='eza --oneline --all --icons=always --group-directories-first --long --sort=Extension --group --no-time --binary'
alias lll='eza --oneline --all --icons=always --group-directories-first --long --sort=Extension --no-user --modified --time-style "+%Y/%m/%d %H:%M" --binary --git --git-repos'
alias tags='ctags --recurse --sort=yes --exclude=.git --exclude=venv --exclude="*.rst" --excmd=number'
alias abook='abook --config ~/.config/abook/abookrc --datafile ~/.deivis_datos/arquivos/persoas/contactos/abookdb'
# alias new='newsraft'
alias new='newsboat'

# FUNCIONS ----------------------------------------------------------


function z() { command zathura --fork "$@" 2>/dev/null & }

function te() {
    local result=$(command tere "$@")
    [ -n "$result" ] && cd -- "$result"
}

function yazicd() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}
bind '"\C-o":"yazicd\C-m"'

function o() {
    IFS=$'\n'
    # lista a partir dos elementos seleccionados por fzf separados por IFS
    resultados=($( command fzf --query="$1" --select-1 --exit-0 --preview "batcat -n --color=always {}"))
    [ -n "$resultados" ] && ${EDITOR:-nvim} "${resultados[@]}"
}

function t() {
    dir=$(
        command fd -p --type d --hidden -E .git . 2>/dev/null |
        command fzf --preview "eza -a --tree --only-dirs -L 2 --color=always --icons=always --long -b --no-user --changed -I .git {}"
    )
    [ -n "$dir" ] && builtin cd "$dir" && clear && l
}

gr () {
    git_root=$(git rev-parse --show-toplevel 2>/dev/null)
    [ -z "$git_root" ] || cd "$git_root" || return $@
}
disks () { lsblk -o NAME,TYPE,TRAN,STATE,LABEL,PARTLABEL,VENDOR; }
diskss () { lsblk -o NAME,PATH,MOUNTPOINT,FSTYPE,FSUSE%,SIZE; }
disksss () { lsblk -o NAME,PATH,MOUNTPOINT,FSTYPE,FSUSE%,SIZE,TYPE,TRAN,STATE,LABEL,PARTLABEL,VENDOR; }
car () { mkdir -p -- "$1" && cd -P -- $@; }
up() { cd $(eval printf '../'%.0s {1..$1}); }
help() { "$@" --help 2>&1 | command batcat --plain --language=help; }

# ftags - search ctags with preview
# only works if tags-file was generated with --excmd=number
ftags() {
    local line
    [ -e tags ] && line=$(
        awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
            fzf \
            --nth=1,2 \
            --with-nth=2 \
            --preview-window="50%" \
            --preview="batcat {3} --color=always --style=plain | tail -n +\$(echo {4} | tr -d \";\\\"\")"
    ) &&
    ${EDITOR:-nvim} $(cut -f3 <<< "$line")  \
    -c "silent tag $(cut -f2 <<< "$line")"
}

# simple fzf con nvim
prob() {
    rg --color=always --line-number --no-heading --smart-case "${*:-}" |
      fzf --ansi \
          --delimiter : \
          --preview 'batcat --style=plain --color=always {1} --highlight-line {2}' \
          --bind 'enter:become(nvim {1} +{2})'
}

funcs () {
    declare -f | perl -0777 -pe 's/^}\n/}\0/gm' |
    command batcat --style=plain --language bash --color always |
    fzf --read0 --ansi --gap=1
    # usar bat coutra vez fai que falle o prompt
    # | command batcat --style=plain --language bash --color always
}
