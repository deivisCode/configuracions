vim.o.autoindent     = false -- Copiar indentacion da liña actual ao crear unha nova
vim.o.autoread       = true  -- (re)lee ficheiro se se cambiou fora de neovim
vim.o.breakindent    = true -- liñas dobladas continuan indentadas
-- vim.o.breakindentopt = 'shift:3' -- as sobladas están desplazadas
vim.o.complete       = '.' -- onde buscar completados
vim.o.completeopt    = 'fuzzy,menuone,popup,noinsert'
vim.o.confirm        = true
vim.o.cursorline     = true
vim.opt.cmdheight    = 1
vim.o.expandtab      = true
vim.o.foldcolumn     = 'auto:3'
vim.o.foldmarker     = "{{{{,}}}}"
vim.o.foldmethod     = 'marker'
vim.o.foldminlines   = 2
vim.o.formatoptions  = 'tcql' -- prbably use an autocmd, otherwise ftplugs override this
vim.o.grepprg        = "rg -i -U --vimgrep --smart-case $*"
vim.o.history        = 100 -- how many : and / commands and patterns are stored
vim.o.ignorecase     = true
vim.o.laststatus     = 3  -- Só unha
vim.o.linebreak      = true -- dobleces en 'breakat'
vim.o.list           = true
-- vim.o.messagesopt     = "history:5000,timeout:3000,maxheight:50"
vim.o.matchtime      = 10
vim.o.mouse          = 'n' -- disable mouse support
vim.o.mousehide      = true
vim.o.nrformats      = 'bin,hex,alpha,unsigned'
vim.o.number         = true
vim.o.numberwidth    = 3
vim.o.pumblend       = 20   -- transparencia para os popups
vim.o.pumheight      = 10  -- tamaño maximo dos popups
vim.o.relativenumber = true
vim.o.report         = 1
vim.o.scrolloff      = 5 -- Minimo de liñas que manter antes/despois do cursor
vim.o.scrollopt      = 'ver,hor,jump'
vim.o.shada          = '' -- Nome. Se está baleira non se lee
vim.o.shadafile      = 'NONE'
vim.o.shell          = '/bin/bash'
vim.o.shellcmdflag   = '-c'
vim.o.shiftwidth     = 4
vim.o.shortmess      = 'atTIqwuWF' -- shortify some messages. :FACER: da erro se meto o lazy init en plugin/
vim.o.showbreak      = '↳'
vim.o.showmatch      = true
vim.o.showmode       = false -- show current mode in cmd line
vim.o.smartcase      = true
vim.o.smarttab       = true
vim.o.softtabstop    = 4
vim.o.spelloptions   = "camel,noplainbuffer" -- Spelear palabras separadas con camelcase
vim.o.splitbelow     = true
vim.o.splitright     = true
vim.o.suffixes       = 'pdf' -- ficheiros con menos prioridade para autocompletados
vim.o.swapfile       = true -- activar a swapfile
vim.o.tabstop        = 4
vim.o.termguicolors  = true
vim.o.timeoutlen     = 400 -- Tempo de espera para mapeos
vim.o.title          = true
vim.o.titlestring    = 'NEOVIM DEIVIS'
vim.o.virtualedit    = 'all'
vim.o.wildignorecase = true
vim.o.wildmode       = "longest,full"
vim.o.winborder      = "single" -- e.g. Oil :FACER: ",,,│,,,, " bugueado con blink
vim.o.previewpopup   = "border:single"
vim.o.pumborder      = "single" -- e.g. <C-n>
vim.o.winheight      = 5
vim.o.winwidth       = 5
vim.o.wrap           = false -- dobleces

vim.opt.isfname:remove{
    ',',
    '{',
    '}',
    '#',
    '[',
    ']',
    ':',
}

vim.opt.thesaurus:append{
    "/home/david/deivis_datos/recursos/codigo/thesaurus/th_gl.txt",
    "/home/david/deivis_datos/recursos/codigo/thesaurus/th_GL.txt",
}

vim.opt.diffopt = {
    "algorithm:patience",
    "closeoff",
    "context:3",
    "filler",
    "indent-heuristic",
    "inline:char",
    "linematch:40",
}

vim.opt.fillchars = {
    eob       = ' ',
    stl       = ' ',
    stlnc     = ' ',
    foldopen  = '>',
    foldsep   = '│',
    fold      = '-',
    foldclose = '',
    diff      = '╱',
    horizup   = '─',
    horizdown = '─',
    vertleft  = '│',
    vertright = '│',
    verthoriz = ' ',
}

vim.opt.listchars = {
    tab            = '-->',
    leadmultispace = '┊   ',
    extends        = '→',
    precedes       = '→',
    nbsp           = '⍽',
    space          = ' ',
}

vim.opt.wildignore = {
    '*/.git/*',
    '*.exe',
    '*.dll',
    '*.so',
    '*.tar',
    '*.tar.gz',
    '*.gz',
    '*.zip',
    '*.7z',
    '*.jpg',
    '*.png',
    '*.jpeg',
    '*.jpg',
    '*.jpg',
    '.pyc',
    '*/__pycache__/*',
}

vim.opt.wildoptions = "fuzzy,pum"
