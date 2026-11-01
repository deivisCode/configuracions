
# Variables de entorno --------------------------------------------------------

export BIBTOOLRSC="$HOME/.config/bibtool/config.rsc"
export EDITOR="nvim"
export BROWSER="librewolf"
export FZF_DEFAULT_COMMAND="fd --type f --hidden"
export FZF_DEFAULT_OPTS=' --layout=reverse --multi --preview-window=down:70%,border-top --info=inline-right --no-scrollbar --prompt="~ " --header="" --color=dark --color=fg:-1,bg:-1,hl:#ed5151,fg+:#ffffa8,bg+:-1,hl+:#ed5151 --color=info:-1,prompt:-1,pointer:#ffffa8,marker:#ffffa8,spinner:#ff87d7'
export GIT_COMPLETION_CHECKOUT_NO_GUESS=1
export GIT_COMPLETION_IGNORE_CASE=1
export GIT_COMPLETION_SHOW_ALL=1
export GIT_COMPLETION_SHOW_ALL_COMMANDS=1
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWCOLORHINTS=1 # cores de git status -sb
export GIT_PS1_SHOWCONFLICTSTATE="yes"
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_STATESEPARATOR=") ("
export GIT_PS1_SHOWUPSTREAM="verbose name"
export HISTCONTROL="erasedups:ignoreboth" # non gardar liñas duplicadas ou con espazos no historial
export HISTFILESIZE=200
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear:c:q:p:t:o:n:l:yazicd:lf:cd"
export HISTSIZE=100
export INFOPATH="/usr/local/texlive/2025/texmf-dist/doc/info"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export GOPATH="$HOME/go/bin"
export PATH="/usr/local/texlive/2025/bin/x86_64-linux:$PATH"
export PATH="/home/david/.juliaup/bin:$PATH"
export PROMPT_COMMAND='echo " ";'
export PROMPT_DIRTRIM=4
export PS1='\[\e[1;31m\]@\[\e[m\] \w\n\[\e[1;33m\]\\$\[\e[m\]$(__git_ps1) '
export W3M_DIR="$HOME/.config/w3m"
export COIN_GL_NO_CURRENT_CONTEXT_CHECK=1 # para Freecad: FreeCAD: ./src/glue/gl.cpp:2234: const cc_glglue* cc_glglue_instance(int): Assertion `current_ctx && "Must have a current GL context when instantiating cc_glglue!! (Note: if you are using an old Mesa GL version, set the environment variable COIN_GL_NO_CURRENT_CONTEXT_CHECK to get around what may be a Mesa bug.)"' failed. Aborted (core dumped)
export MPLCONFIGDIR="$HOME/.deivis_datos/recursos/codigo/python/matplotlib"

# SHELLOPTS -------------------------------------------------------------------
shopt -s autocd 2> /dev/null # Prepend cd to directory names automatically
shopt -s checkwinsize # chequear tamaño da ventana e refrescar se fose necesario
shopt -s dotglob # diretorios ocultos aparecen cando se usa *
shopt -s extglob
shopt -s globstar 2> /dev/null
shopt -s histappend # engadir ao final do historial en vez de sobreescribilo
shopt -s histverify
shopt -s nocaseglob
shopt -s nullglob
set -o noclobber
set -o vi

# bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"
bind "set mark-symlinked-directories on"
bind Space:magic-space
bind 'set show-mode-in-prompt on'
bind 'set vi-ins-mode-string \1\e[6 q\2'
bind 'set vi-cmd-mode-string \1\e[2 q\2'
