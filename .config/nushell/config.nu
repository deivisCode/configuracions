source comp_git.nu

# Diretorios para os plugins
const NU_PLUGIN_DIRS = [
    ($nu.current-exe | path dirname)
    ...$NU_PLUGIN_DIRS
]

alias c       = clear
alias ..      = cd ..
alias n       = nvim
alias q       = exit
alias fg      = job unfreeze
alias loc     = which
alias sai     = sudo apt install
alias dots    = /usr/bin/git --git-dir=$"($env.HOME)"/.deivis_cfg/ --work-tree=$"($env.HOME)"
alias probas  = cd /home/david/.deivis_datos/codigos/.probas/
alias pro     = cd /home/david/.deivis_datos/proxectos
alias rec     = cd /home/david/.deivis_datos/recursos
alias uni     = cd /home/david/.deivis_datos/proxectos/uni/
alias daf     = cd /home/david/.deivis_datos/proxectos/uni/DAF/
alias lingua  = cd /home/david/.deivis_datos/proxectos/uni/lingua/
alias dic     = cd /home/david/.deivis_datos/proxectos/uni/lingua/dicionario/repositorio/
alias revista = cd /home/david/.deivis_datos/proxectos/uni/revista/
alias apuntes = cd /home/david/.deivis_datos/proxectos/uni/apuntes/
alias libros  = cd /home/david/.deivis_datos/arquivos/libros
alias finfo   = fonttools ttx -l
alias exi     = exiftool -g -ee -u -U
alias fontes  = typst fonts --ignore-system-fonts --ignore-embedded-fonts --font-path . --variants

def traballo_git [] {
    git log --pretty=%h»¦«%aN»¦«%s»¦«%aD
    | lines
    | split column "»¦«" sha1 committer desc merged_at
    | histogram committer merger
    | sort-by count
    | reverse
    | select committer count percentage
}

# :FACER:
# 'sd'  -> fd -tf --exec fd 'a' 'b'
# 'sad' -> fd -tf | sad 'a' 'b'
# rga e logo pdf
# tags/ctags?

# :FACER: ACABAR
# def bib [] {
#     # Argumentos para FZF
#     let argumentos_fzf = [
#         --ansi
#         --with-shell "nu -c"
#         # --delimiter ":"
#         --preview 'yq -y .{1} a.yaml | batcat -l yaml --color=always --style=plain'
#         --bind $"start:reload\(yq -r keys[] a.yaml | lines | each { |ref| \$'\(\$ref\) : \(hayagriva a.yaml reference --style apa --key $ref\)' } | str join '\n'\)"
#         --accept-nth 1
#     ]
#     let seleccion = (^fzf ...$argumentos_fzf)
#     $seleccion | $'(^yq -ry .$"($in)" a.yaml)' | batcat -l yaml --style plain
# }
# :FACER:
# def function p [] {
#     let pdfs="/home/david/deivis_datos/arquivos/artigos/bibliografia/pdf/"
#     let bib="/home/david/deivis_datos/arquivos/artigos/bibliografia/bibliografia.bib"
#     local resultado =
#         command fdfind -e pdf -u --type file --full-path "$pdfs" |
#             fzf --prompt "PDFs > " \
#                 --header "^F PDFs / ^B BIBs" \
#                 --preview 'rga --pretty --context 5 {q} {}'
#                 --bind 'ctrl-d:change-prompt(Directorios> )+reload(fdfind --hidden --type file --full-path -E .git . 2>/dev/null)' \
#                 --bind 'ctrl-f:change-prompt(PDFs > )+reload(fdfind -e pdf -u --type file "$pdfs")' \
#                 --bind 'ctrl-f:change-prompt(Ficheiros> )+reload(fdfind -p --type d --hidden -E .git . 2>/dev/null)'
#                 --bind 'ctrl-f:change-prompt(BIBs > )+reload(rg ) \
#     xdg-open $resultados
#     echo "$resultado"
# }


# Actualizar APT e listar cousas (orixinalmente en windows 'Scoop Update, Scoop Status --> SUS)
def sus [] { sudo apt update; apt list --upgradable }

# Abrir PDFs con zathura
def z [pdf] { zathura --fork $pdf }

# Listar directorios bonitos
def l [dir?] { eza -A --color=always --git-repos --git --group-directories-first --icons=always ($dir | default ".")}
def ll [dir?] { eza -Alg --git --git-repos --sort name --group-directories-first --color=always --icons=always ($dir | default ".")}

# Atallo porque me é imposible usar lsblk -o ... de memoria
def disks   [] { lsblk -o NAME,TYPE,TRAN,STATE,LABEL,PARTLABEL,VENDOR }
def diskss  [] { lsblk -o NAME,PATH,MOUNTPOINT,FSTYPE,FSUSE%,SIZE }
def disksss [] { lsblk -o NAME,PATH,MOUNTPOINT,FSTYPE,FSUSE%,SIZE,TYPE,TRAN,STATE,LABEL,PARTLABEL,VENDOR }

# Moverse con YAZI
def --env y [...args] {
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    ^yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp)
    if $cwd != $env.PWD and ($cwd | path exists) {
        cd $cwd
    }
    rm -fp $tmp
}

# (O)pen file
# Abre ficheiros buscando por nome
def o [...defecto] {
    let resultados = fzf --select-1 --exit-0 --preview "batcat -n --color=always {}" | lines
    if not ($resultados | is-empty) {
        nvim ...$resultados
    }
}

# (R)ipgrep
# Abre ficheiros buscando seus contidos. Unha locura de facer...
def r [ patron?: string ] {
    let inicial = ($patron | default "")

    # Argumentos para FZF
    let argumentos_fzf = [
        --ansi
        --query $inicial # patrón de búsqueda inicial
        --delimiter ":"
        # Que é o que previsualizamos? ficheiro+liña, ousexa {1}+{2}
        --preview 'batcat --style=numbers --color=always {1} --highlight-line {2}'
        --preview-window 'down:70%:+{2}+3/3,border-top'
        # (copiado de fzf --man) Tanto no comezo do proceso como no cambio da consulta, reexecutamos RG cos contidos da consulta
        --bind 'start:reload(rg --column --line-number --no-heading  --no-hidden --color=always {q} || true)'
        --bind 'change:reload(rg --column --line-number --no-heading --no-hidden --color=always {q} || true)'
    ]

    # Liñas (táboa de nushell) de cousas seleccionadas
    let seleccion = (^fzf ...$argumentos_fzf | lines)

    # No caso de que SI seleccionásemos algo
    if not ($seleccion | is-empty) {
        # Se seleccionamos unha soa cousa, abrímola directamente con nvim
        if ($seleccion | length) == 1 {
            let partes = ($seleccion | first | split row ":")
            nvim $"+($partes.1)" $partes.0
        # Se resultadosamos varias, creamos unha quickfixlist, gardando a
        # selección nun ficheiro temporal e cargándoo
        } else {
            let tmp = (mktemp)
            $seleccion | save --force $tmp
            nvim -q $tmp
            rm $tmp
        }
    }
}

# (T)o file
# Filtrar diretorios con fzf e ir a eles. Previsualización con 'tree'
def --env t [ ] {
    let dir = fd -p --type d --hidden -E .git .
        # alternativas:
        # tree -adpugFC -L 3 --sort name --noreport
        | fzf --multi=1 --preview "eza -ADTlg --git --git-repos --icons=always -L 2 --sort name --color=always {}"
    if (not ($dir | is-empty)) and $dir != $env.PWD and ($dir | path exists)  {
        cd $dir
        clear
        l
    }
}

# Función que devolve a ruta actual, algo acurtada. Úsase no PROMPT máis adiante
def onde [] {
    # Non vou mentir, esquecinme como funcina exactamente este match {}
    let estouen = match (do -i { $env.PWD | path relative-to $env.HOME }) {
        # Se estou en $HOME
        '' => '~'
        # Se estou nalgures pai de $HOME
        null => {
            if ($env.PWD | path split | length ) <= 4 {
                $env.PWD
            } else {
                $"/.../($env.PWD | path split | last 3 | str join '/')" # acurtamos a ruta
            }
        }
        # Se estou nalgures fillo de $HOME
        $relative_pwd => {
            if ($relative_pwd | path split | length ) <= 3 {
                $"~/($relative_pwd)"
            } else {
                $"~/.../($relative_pwd | path split | last 3 | str join '/')"
            }
        }
    }
    $"($estouen)"
}

# info de git. Si, foi un cristo escribilo todo
def gitinfo [] {
    let info = (gstat) # fai falla ter GSTAT (esquecinme de como se instala XD)
    if ($info | get repo_name) == "no_repository" { return }

    let repo    = if ($info | get repo_name) != "no_repository" { $info | get repo_name }
    let tag     = if ($info | get tag      ) != "no_tag"        { $info | get tag       }
    let bran    = if ($info | get branch   ) != "no_branch"     { $info | get branch    }
    let remo    = if ($info | get remote   ) != "no_remote"     { $info | get remote    }
    let stat    = if ($info | get state    ) != "no_state"      { $info | get state     }
    let igno    = if ($info | get ignored  ) > 0 { $info | get ignored   }
    let conf    = if ($info | get conflicts) > 0 { $" (ansi red)($info   | get conflicts)(ansi reset)" }
    let ahea    = if ($info | get ahead    ) > 0 { $" (ansi blue)($info   | get ahead)(ansi reset)"     }
    let behi    = if ($info | get behind   ) > 0 { $" (ansi blue)($info   | get behind)(ansi reset)"    }
    let stas    = if ($info | get stashes  ) > 0 { $" (ansi blue)\$($info  | get stashes)(ansi reset)"   }

    let wt_untr = if ($info | get wt_untracked    ) > 0 { $"(ansi red)?($info | get wt_untracked   )(ansi reset)" }
    let wt_modi = if ($info | get wt_modified     ) > 0 { $"(ansi red)M($info | get wt_modified    )(ansi reset)" }
    let wt_dele = if ($info | get wt_deleted      ) > 0 { $"(ansi red)D($info | get wt_deleted     )(ansi reset)" }
    let wt_type = if ($info | get wt_type_changed ) > 0 { $"(ansi red)T($info | get wt_type_changed)(ansi reset)" }
    let wt_rena = if ($info | get wt_renamed      ) > 0 { $"(ansi red)R($info | get wt_renamed     )(ansi reset)" }

    let idx_as  = if ($info | get idx_added_staged    ) > 0 { $"(ansi green)A($info | get idx_added_staged   )(ansi reset)" }
    let idx_ms  = if ($info | get idx_modified_staged ) > 0 { $"(ansi green)M($info | get idx_modified_staged)(ansi reset)" }
    let idx_ds  = if ($info | get idx_deleted_staged  ) > 0 { $"(ansi green)D($info | get idx_deleted_staged )(ansi reset)" }
    let idx_r   = if ($info | get idx_renamed         ) > 0 { $"(ansi green)R($info | get idx_renamed        )(ansi reset)" }
    let idx_tc  = if ($info | get idx_type_changed    ) > 0 { $"(ansi green)T($info | get idx_type_changed   )(ansi reset)" }

    let p = ( $"(ansi green)($bran)(ansi reset)" ++ $"($ahea)" ++ $"($behi)" ++ $"($stas)" ++ $"($igno)" ++ $"($conf)")
    let wt = ( $"($wt_untr)" ++ $"($wt_modi)" ++ $"($wt_dele)" ++ $"($wt_type)" ++ $"($wt_rena)")
    let idx = ( $"($idx_as)" ++ $"($idx_ms)" ++ $"($idx_ds)" ++ $"($idx_r )" ++ $"($idx_tc)")

    let esquerda = if ($"($wt)"  == "") { "" } else { $"(ansi grey)wt(ansi reset)[($wt)] " }
    let dereita  = if ($"($idx)" == "") { "" } else { $"(ansi grey)in(ansi reset)[($idx)] " }

    $"\(($p)\) ($esquerda)($dereita)"
}

# PATH
$env.path ++= [
    "/usr/local/texlive/2025/bin/x86_64-linux"
    "/home/david/.juliaup/bin"
    ($env.HOME + "/.cargo/bin")
    ($env.HOME + "/go/bin/bin")
    ($env.HOME + "/.local/bin")
    ($env.HOME + "/go/bin")
    ($env.HOME + "/.cabal/bin")
    ($env.HOME + "/.ghcup/bin")
]
# deduplicar e ordear a PATH
$env.PATH = ($env.PATH | uniq | sort )

# Cores de `ls`
# https://www.bigsoft.co.uk/blog/2008/04/11/configuring-ls_colors
$env.LS_COLORS = (
    "*~=0;38;2;126;126;126:"
    ++ "no=0;"
    ++ "fi=0:"
    ++ "di=1;34:"
    ++ "ln=04;36:"
    ++ "ex=0;33:"
    ++ "*.git=0;38;2;135;174;134:"
    ++ "*.gitconfig=0;38;2;135;174;134:"
    ++ "*.gitignore=0;38;2;135;174;134:"
)

# Variables de entorno
$env.BIBTOOLRSC                           = $env.HOME + "/.config/bibtool/config.rsc"
$env.EDITOR                               = "nvim"
$env.VISUAL                               = "nvim"
$env.BROWSER                              = "librewolf"
$env.FZF_DEFAULT_COMMAND                  = "fd --type f --hidden"
$env.FZF_DEFAULT_OPTS                     = "
    --layout=reverse
    --multi
    --preview-window=down:70%,border-top
    --info=inline-right
    --no-scrollbar
    --prompt='  ~ '
    --header=''
    --color=dark
    --color=fg:#ffffff,bg:-1,hl:#ed5151,fg+:#ffffa8,bg+:-1,hl+:#ed5151
    --color=info:#87afaf:,prompt:#ffffff,pointer:#ffffa8,marker:#ffffa8,spinner:#ff87d7,header:#87afaf,gutter:#000000
    --bind='ctrl-q:select-all'
    --bind='ctrl-b:clear-selection'
    --bind='ctrl-t:toggle-all'
"
$env.INFOPATH                             = "/usr/local/texlive/2025/texmf-dist/doc/info"
$env.GOPATH                               = $env.HOME + "/go/bin"
$env.W3M_DIR                              = $env.HOME + "/.config/w3m"
$env.COIN_GL_NO_CURRENT_CONTEXT_CHECK     = 1 # para Freecad: FreeCAD: ./src/glue/gl.cpp:2234: const cc_glglue* cc_glglue_instance(int): Assertion `current_ctx && "Must have a current GL context when instantiating cc_glglue!! (Note: if you are using an old Mesa GL version, set the environment variable COIN_GL_NO_CURRENT_CONTEXT_CHECK to get around what may be a Mesa bug.)"" failed. Aborted (core dumped)
$env.MPLCONFIGDIR                         = $env.HOME + "/.deivis_datos/recursos/codigo/python/matplotlib"
$env.PROMPT_COMMAND_RIGHT                 = ''
$env.PROMPT_INDICATOR_VI_NORMAL           = $"(ansi yellow_bold)$(ansi reset) "
$env.PROMPT_INDICATOR_VI_INSERT           = $"(ansi yellow_bold)$(ansi reset) "
$env.PROMPT_COMMAND                       = { $"(ansi red_bold)@(ansi reset) (ansi white)(onde)\n(gitinfo)" }
$env.PROMPT_MULTILINE_INDICATOR           = ": "
$env.TRANSIENT_PROMPT_COMMAND             = $"(ansi red_bold)>>>(ansi reset)"
$env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = ""
$env.GH_TELEMETRY                         = false

# Cores para nushell (para o prompt)
let cores = {
    leading_trailing_space_bg  : { attr: n }
    hints                      : "#585858"
    string                     : "white"
    float                      : "white"
    glob                       : "white"
    binary                     : "white"
    custom                     : "white"
    nothing                    : "white"
    date                       : "white"
    filesize                   : "white"
    list                       : "white"
    record                     : "white"
    duration                   : "white"
    range                      : "white"
    cell-path                  : "white"
    closure                    : "white"
    block                      : "white"
    search_result              : "white"
    header                     : "white"
    separator                  : "white"
    row_index                  : "white"
    empty                      : "white"
    banner_foreground          : "white"
    banner_highlight1          : "white"
    banner_highlight2          : "white"
    shape_binary               : "white"
    shape_block                : "white"
    shape_bool                 : { fg: "#FFFFA8" attr: bu}
    shape_closure              : "white"
    shape_custom               : "white"
    shape_datetime             : "white"
    shape_directory            : "white"
    shape_external             : "white"
    shape_external_resolved    : "white"
    shape_externalarg          : "white"
    shape_filepath             : "white"
    shape_flag                 : "white"
    shape_float                : "yellow"
    shape_garbage              : "white"
    shape_glob_interpolation   : "#FF803E"
    shape_globpattern          : "#FF803E"
    shape_int                  : "yellow"
    shape_internalcall         : "white"
    shape_keyword              : "white"
    shape_list                 : "white"
    shape_literal              : "white"
    shape_match_pattern        : { fg: "white" bg: "red" attr:ub }
    shape_matching_brackets    : "white"
    shape_nothing              : "white"
    shape_operator             : "white"
    shape_pipe                 : { fg: "#FFFFA8" attr: bold}
    shape_range                : "white"
    shape_raw_string           : "white"
    shape_record               : "white"
    shape_redirection          : "white"
    shape_signature            : "white"
    shape_string               : "green"
    shape_string_interpolation : "#FF803E"
    shape_table                : "white"
    shape_vardecl              : "white"
    shape_variable             : "white"
}

$env.config.color_config                = $cores
$env.config.show_banner                 = false
$env.config.buffer_editor               = "nvim" # ctrl-o
$env.config.table.mode                  = "psql"
$env.config.edit_mode                   = "vi"
$env.config.history.max_size            = 1_000
$env.config.history.file_format         = "sqlite"
$env.config.history.isolation           = true
$env.config.cursor_shape.emacs          = "inherit" # Cursor shape in emacs mode
$env.config.cursor_shape.vi_insert      = "line" # Cursor shape in vi-insert mode
$env.config.cursor_shape.vi_normal      = "block" # Cursor shape in normal vi mode
$env.config.show_hints                  = true
$env.config.completions.algorithm       = "prefix"
$env.config.completions.case_sensitive  = false
$env.config.completions.sort            = "alphabetical"
$env.config.completions.partial         = true
$env.config.completions.quick           = true
$env.config.completions.external.enable = true
$env.config.use_kitty_protocol          = true
$env.config.shell_integration.osc2      = true
$env.config.shell_integration.osc7      = true
$env.config.shell_integration.osc8      = true
$env.config.shell_integration.osc9_9    = false
$env.config.shell_integration.osc133    = true
$env.config.shell_integration.osc633    = false
$env.config.bracketed_paste             = true
$env.config.error_style                 = "fancy"
$env.config.table.index_mode            = "auto"
$env.config.table.padding.left          = 1
$env.config.table.padding.right         = 1
$env.config.datetime_format.normal      = "%d/%m/%y %I:%M:%S%p"
$env.config.filesize.unit               = 'metric'
$env.config.filesize.show_unit          = true
$env.config.filesize.precision          = 2
$env.config.ls.use_ls_colors            = true
$env.config.completions.use_ls_colors   = true
$env.config.table.trim                  = {
    methodology: "wrapping"
    wrapping_try_keep_words: true
}

$env.config.menus = []
$env.config.menus ++= [{
    name: help_menu
    only_buffer_difference: true # Search is done on the text written after activating the menu
    marker: "? "                 # Indicator that appears with the menu is active
    type: {
        layout: description      # Type of menu
        columns: 4               # Number of columns where the options are displayed
        col_width: 20            # Optional value. If missing all the screen width is used to calculate column width
        col_padding: 2           # Padding between columns
        selection_rows: 4        # Number of rows allowed to display found options
        description_rows: 10     # Number of rows allowed to display command description
    }
    style: {
        text: green                   # Text style
        selected_text: green_reverse  # Text style for selected option
        description_text: yellow      # Text style for description
    }
}]

$env.config.menus ++= [{
    name: completion_menu
    only_buffer_difference: false
    marker: $"(ansi blue_bold)[COMP](ansi reset) "
    type: {
        layout: columnar
        columns: 4
        col_width: 20
        col_padding: 2
    }
    style: {
        text: { fg:white }
        selected_text: { fg:"#FFFFA8" attr:b }
        description_text: "#585858"
    }
}]

$env.config.menus ++= [{
    name: history_menu
    only_buffer_difference: false
    marker: $"(ansi green_bold)[HIS] "
    type: {
        layout: list
        page_size: 10
    }
    style: {
        text: white
        selected_text: { fg:"#FFFFA8" attr:b}
    }
}]
