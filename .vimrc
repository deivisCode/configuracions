set belloff=all
set breakindent
set complete=.
set completeopt=menuone,popup,noinsert
set confirm
set cursorline
set expandtab
set fillchars=stl:\ ,stlnc:\ ,foldopen:,foldclose:,foldsep:│,diff:╱
set formatoptions=tcql
set history=100
set ignorecase
set incsearch
set isfname-=#
set isfname-=,
set isfname-=:
set isfname-=[
set isfname-=]
set isfname-={
set isfname-=}
set laststatus=2
set linebreak
set list
set listchars=tab:--,leadmultispace:┊\ \ \ \ ,extends:→,precedes:→,nbsp:⍽
set mouse=n
set mousehide
set noswapfile
set nrformats=bin,hex,alpha,unsigned
set number
set numberwidth=3
set relativenumber
set report=0
set scrolloff=10
set scrollopt=ver,hor,jump
set shiftwidth=4
set shortmess=tTcI
set showbreak=↳
set smartcase
set smarttab
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set termguicolors
set timeoutlen=400
set title
set titlestring=VIM\ DEIVIS
set undolevels=100
set virtualedit=all
set wildignore=*/.git/*,*.exe,*.dll,*.so,*.tar,*.tar.gz,*.gz,*.zip,*.7z,*.jpg,*.pdf,*.png,*.jpeg,*.jpg,*.jpg,.pyc,*/__pycache__/*
set wildmode=longest,full
set wildoptions+=fuzzy

"Autocomandos
au WinLeave * set nocursorline
au WinEnter * set cursorline
au InsertEnter * set nocursorline
au InsertLeave * set cursorline
au TerminalWinOpen * set norelativenumber nonumber


" Comandos de usuario
command Trim %s/\s\+$//e

" Entrar no modo comando
nnoremap , :
xnoremap , :

" Visual Bloc
nnoremap vb <C-v>
xnoremap vb <S-v>

" Visual line
nnoremap vl <S-v>
xnoremap vl <S-v>

" Modo normal
inoremap kj <ESC>
inoremap jk <ESC>
inoremap KJ <ESC>
inoremap JK <ESC>
tnoremap <ESC> <C-\><C-n>
tnoremap kj <C-\><C-n>
tnoremap jk <C-\><C-n>
tnoremap KJ <C-\><C-n>
tnoremap JK <C-\><C-n>

" Limpar
nnoremap <ESC> <ESC>:noh<CR>:echo<ESC>

" Mover arriba e abaixo ignorando wrap
nnoremap <expr> k v:count==0?'gk':'k'
xnoremap <expr> k v:count==0?'gk':'k'
nnoremap <expr> j v:count==0?'gj':'j'
xnoremap <expr> j v:count==0?'gj':'j'

" Moverse entre ventanas
nnoremap <A-h> <C-w><C-h>
nnoremap <A-j> <C-w><C-j>
nnoremap <A-k> <C-w><C-k>
nnoremap <A-l> <C-w><C-l>

" Textobjects
xnoremap il g_o^
onoremap il :<C-u>normal vil<CR>
xnoremap al $o0
onoremap al :<C-u>normal val<CR>
xnoremap ir i[
onoremap ir :<C-u>execute 'normal v' . v:count1 . 'i['<CR>
xnoremap ar a[
onoremap ar :<C-u>execute 'normal v' . v:count1 . 'a['<CR>
onoremap iq i"
onoremap aq a"
xnoremap iq i"
xnoremap aq a"
xnoremap ik `]o`[
onoremap ik :<C-u>normal vik<CR>
onoremap ak :<C-u>normal vikV<CR>
nnoremap gp `[v`]

" Busqueda e reemplazo
nnoremap s /
nnoremap S ?
xnoremap s :s///gc<Left><Left><Left><Left>

" Espazos
nnoremap <space><space> a<space><ESC>h

" Mover liñas
xnoremap <A-j> :move'>+1<CR>gv
xnoremap <A-k> :move'<-2<CR>gv

" Crear liñas baleiras
nnoremap oo o<ESC>k
nnoremap OO o<ESC>j
nnoremap oO o<ESC>kO<ESC>j
nnoremap Oo o<ESC>kO<ESC>j

" Indentacion
nnoremap > >>
nnoremap < <<
xnoremap > >gv
xnoremap < <gv

" Mover ventanas
nnoremap <C-h> <C-w>H
nnoremap <C-j> <C-w>J
nnoremap <C-l> <C-w>L
nnoremap <C-k> <C-w>K

" Tamañose ventanas
nnoremap <C-Up> :resize +1<CR>
nnoremap <C-Down> :resize -1<CR>
nnoremap <C-Left> :vertical resize -1<CR>
nnoremap <C-Right> :vertical resize +1<CR>

" Autoinsertado
inoremap <A-b> <Left>
inoremap <A-r> []<Left>
inoremap <A-B> {}<Left>
inoremap <A-"> ""<Left>
inoremap <A-'> ''<Left>
inoremap <A-BS> <BS><Del>

" Cores
highlight link DiagnosticError ErrorMsg
highlight link DiffText DiffDelete
highlight link Todo Error
highlight link Float Number
highlight link pythonOperator Keyword
highlight link requirementsVersionSpecifiers Operator
highlight Added guifg=#00FF00 guibg=#001D02
highlight AddedNr guifg=#00FF00 gui=bold
highlight Changed guifg=#6AFFFF guibg=#1A1A33
highlight ChangedNr guifg=#6AFFFF gui=bold
highlight CursorLine guibg=#242A30
highlight CursorLineNr guifg=#ED5151 guibg=#242A30 gui=bold
highlight DiagnosticHint guifg=#AB9DF2 gui=bold
highlight DiagnosticInfo guifg=#528BFF gui=bold
highlight DiagnosticWarn guifg=#FFA948 gui=bold
highlight DiffAdd guibg=#002402
highlight DiffChange guibg=#1A1A33
highlight DiffDelete guifg=#9E1738
highlight Directory guifg=#528BFF gui=bold
highlight EndOfBuffer guifg=#ABB2BF
highlight ErrorMsg guifg=#FF0000 gui=bold
highlight FloatTitle gui=italic
highlight Folded guifg=#434853
highlight IncSearch guifg=#1A1A1A guibg=#6D6D00
highlight LineNr guifg=#666B76
highlight LinhaMarcada guibg=#5a1a1a
highlight MoreMsg guifg=#FFA948 guibg=NONE
highlight NonText guifg=#ACA7D0
highlight Normal guifg=#D9D9D9
highlight NormalFloat guibg=NONE
highlight Pmenu guibg=#242A30
highlight PmenuMatch guifg=#528BFF guibg=#242A30
highlight PmenuMatchSel guifg=#528BFF guibg=#303625 gui=bold
highlight PmenuSel guibg=#303625 gui=bold
highlight Question guifg=NONE gui=bold
highlight QuickFixLine guibg=#242A30
highlight Removed guifg=#FF0000 guibg=#271A1A
highlight RemovedNr guifg=#FF0000 gui=bold
highlight Search guifg=#DDDDDD guibg=#6D6D00
highlight StatusLine guifg=#ABB2BF guibg=#353941
highlight Substitute guifg=#D9D9D9 guibg=#994C00
highlight TabLine guifg=#585858
highlight TabLineSel guifg=#D9D9D9 gui=bold
highlight Title guifg=#AB9DF2 gui=bold,underline
highlight Underlined guifg=#528BFF guibg=NONE gui=underline
highlight Visual guifg=NONE guibg=#272d1b
highlight Whitespace guifg=#434853
highlight WinSeparator guifg=#ABB2BF
highlight qfFileName guifg=#528BFF
highlight Operator guifg=#FFFFA8 gui=bold,nocombine
highlight Delimiter guifg=#FFFFFF gui=bold,nocombine
highlight Function guifg=#6AFFFF gui=nocombine
highlight Boolean guifg=#FFFFA8 gui=bold,underline
highlight Error guifg=#FF0000 gui=bold
highlight Label guifg=#AB9DF2 gui=bold
highlight Conditional guifg=#C051E6 gui=bold
highlight Repeat guifg=#C051E6 gui=bold
highlight Keyword guifg=#C051E6 gui=bold
highlight Exception guifg=#D02000 gui=bold
highlight Include guifg=#BD977D guibg=NONE gui=bold
highlight Comment guifg=#585858
highlight Constant guifg=#D9D9D9
highlight String guifg=#00C632
highlight Character guifg=#FFA948
highlight Number guifg=#FFFF00
highlight Identifier guifg=#D9D9D9
highlight Statement guifg=#C051E6
highlight Type guifg=#AB9DF2
highlight Structure guifg=#D9D9D9
highlight Special guifg=NONE
highlight SpecialChar guifg=#FFA948
highlight pythonStatement guifg=#FFA948 gui=bold
highlight pythonFunction guifg=#528BFF
highlight pythonDecorator guifg=#0080FF gui=bold
highlight pythonDecoratorName guifg=#0080FF gui=bold
