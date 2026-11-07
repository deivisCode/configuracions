local map = vim.keymap.set

vim.g.mapleader = ' '
map( {'n'}     , '<Space>'        , '<Nop>'                                          , { desc = "Espazo non fai nada de por si"})
map( {'n'}     , '<ESC>'          , '<ESC>:noh<CR>:echo<ESC>'                        , { desc = "Escape limpa resaltes e liña de comandos", silent = true })
map( {'n','v'} , ','              , ':'                                              , { desc = "Cambiar a modo comando" } )
map( {'n','v'} , 'vb'             , '<C-v>'                                          , { desc = "Cambiar a modo bloque visual" } )
map( {'n','v'} , 'vl'             , '<S-v>'                                          , { desc = "Cambiar a modo bloque lineal"} )
map( {'t'}     , '<ESC>'          , '<C-\\><C-n>'                                    , { desc = "Saír da terminal inscrustada"} )
map( {'i'}     , 'kj'             , '<ESC>'                                          , { desc = "Saír do modo Insert"} )
map( {'i'}     , 'jk'             , '<ESC>'                                          , { desc = "Saír do modo Insert"} )
map( {'i'}     , 'KJ'             , '<ESC>'                                          , { desc = "Saír do modo Insert"} )
map( {'i'}     , 'JK'             , '<ESC>'                                          , { desc = "Saír do modo Insert"} )
map( {'t'}     , 'kj'             , '<C-\\><C-n>'                                    , { desc = "Saír da terminal inscrustada"} )
map( {'t'}     , 'jk'             , '<C-\\><C-n>'                                    , { desc = "Saír da terminal inscrustada"} )
map( {'t'}     , 'KJ'             , '<C-\\><C-n>'                                    , { desc = "Saír da terminal inscrustada"} )
map( {'t'}     , 'JK'             , '<C-\\><C-n>'                                    , { desc = "Saír da terminal inscrustada"} )
map( {'c'}     , '<A-j>'          , '<Down>'                                         , { desc = "Moverse abaixo no modo comando"} )
map( {'c'}     , '<A-k>'          , '<Up>'                                           , { desc = "Moverse arriba no modo comando"} )
map( {'c'}     , '<A-h>'          , '<Left>'                                         , { desc = "Moverse esquerda no modo comando"} )
map( {'c'}     , '<A-l>'          , '<Right>'                                        , { desc = "Moverse dereita no modo comando"} )
map( {"n","v"} , "k"              , "v:count == 0 ? 'gk' : 'k'"                      , { desc = "Moverse arriba e abaixo ignorando wrap" , expr = true })
map( {"n","v"} , "j"              , "v:count == 0 ? 'gj' : 'j'"                      , { desc = "Moverse arriba e abaixo ignorando wrap" , expr = true })
map( {'n'}     , '<A-h>'          , '<C-w><C-h>'                                     , { desc = "Moverse esquerda entre ventás"})
map( {'n'}     , '<A-j>'          , '<C-w><C-j>'                                     , { desc = "Moverse abaixo entre ventás"})
map( {'n'}     , '<A-k>'          , '<C-w><C-k>'                                     , { desc = "Moverse arriba entre ventás"})
map( {'n'}     , '<A-l>'          , '<C-w><C-l>'                                     , { desc = "Moverse dereita entre ventás"})
map( {'i'}     , '<A-h>'          , '<Left>'                                         , { desc = "Moverse esquerda no modo insertar"} )
map( {'i'}     , '<A-j>'          , '<Down>'                                         , { desc = "Moverse abaixo no modo insertar"} )
map( {'i'}     , '<A-k>'          , '<Up>'                                           , { desc = "Moverse arriba no modo insertar"} )
map( {'i'}     , '<A-l>'          , '<Right>'                                        , { desc = "Moverse dereita no modo insertar"} )
map( {'n'}     , "'"              , '`'                                              , { desc = "Saltar á liña e columna dunha marca"})
map( {'o','v'} , 'iq'             , 'i"'                                             , { desc = "TextObject Inner Quotation Mark"})
map( {'o','v'} , 'aq'             , 'a"'                                             , { desc = "TextObject Around Quotation Mark"})
map( {'x'}     , 'ir'             , 'i['                                             , { desc = "TextObject Around Rectangle"})
map( {'x'}     , 'ar'             , 'i['                                             , { desc = "TextObject Inner Rectangle"})
map( {'x'}     , 'ik'             , '`]o`['                                          , { desc = "TextObject Inner Change" , remap = false})
map( {'n'}     , 'gp'             , '`[v`]'                                          , { desc = "TextObject Around Change", remap = false})
map( {'o'}     , 'ir'             , ":<C-u>execute 'normal v' . v:count1 . 'i['<CR>" , { desc = "TextObject Inner Rectangle"})
map( {'o'}     , 'ar'             , ":<C-u>execute 'normal v' . v:count1 . 'a['<CR>" , { desc = "TextObject Around Rectangle"})
map( {'o'}     , 'ik'             , ':<C-u>normal vik<CR>'                           , { desc = "TextObject Inner Change" , remap = false,})
map( {'o'}     , 'ak'             , ':<C-u>normal vikV<CR>'                          , { desc = "TextObject Around Change", remap = false,})
map( {'n'}     , 's'              , '/'                                              , { desc = "Buscar"})
map( {'n'}     , 'S'              , '?'                                              , { desc = "Buscar atrás"})
map( {'x'}     , 's'              , ':s///gc<Left><Left><Left><Left>'                , { desc = "Substituir"})
map( {'n'}     , '<Space><Space>' , 'a<Space><ESC>h'                                 , { desc = "Engadir un espazo", remap = false} )
map( {'v'}     , '<A-j>'          , ":move'>+1<CR>gv"                                , { desc = "Mover visualmente abaixo", silent = true, remap = false})
map( {'v'}     , '<A-k>'          , ":move'<-2<CR>gv"                                , { desc = "Mover visualmente abaixo", silent = true, remap = false})
map( {'n'}     , 'oo'             , 'o<ESC>k'                                        , { desc = "Crear liña baleira arriba", remap = false })
map( {'n'}     , 'OO'             , 'O<ESC>j'                                        , { desc = "Crear liña baleira abaixo", remap = false })
map( {'n'}     , 'oO'             , 'o<ESC>kO<ESC>j'                                 , { desc = "Crear liña baleira arriba e abaixo", remap = false })
map( {'n'}     , 'Oo'             , 'o<ESC>kO<ESC>j'                                 , { desc = "Crear liña baleira arriba e abaixo", remap = false })
map( {'n'}     , '>'              , '>>'                                             , { desc = "Indentar"})
map( {'n'}     , '<'              , '<<'                                             , { desc = "Desindentar"})
map( {'v'}     , '>'              , '>gv'                                            , { desc = "Indentar"})
map( {'v'}     , '<'              , '<gv'                                            , { desc = "Desindentar"})
-- map( {'n'}     , 'ql'             , '<leader>l'                                      , { desc = "Borrar multicursor", remap = false})
map( {'n'}     , '<C-h>'          , '<C-w>H'                                         , { desc = "Mover ventás pa esquerda", remap = false})
map( {'n'}     , '<C-j>'          , '<C-w>J'                                         , { desc = "Mover ventás pa abaixo"  , remap = false})
map( {'n'}     , '<C-l>'          , '<C-w>L'                                         , { desc = "Mover ventás pa dereita" , remap = false})
map( {'n'}     , '<C-k>'          , '<C-w>K'                                         , { desc = "Mover ventás pa arriba"  , remap = false})
map( {'n'}     , '<C-Up>'         , ':resize +1<CR>'                                 , { desc = "Aumentar tamaño da ventá horizontalmente", silent = true})
map( {'n'}     , '<C-Down>'       , ':resize -1<CR>'                                 , { desc = "Aumentar tamaño da ventá horizontalmente", silent = true})
map( {'n'}     , '<C-Left>'       , ':vertical resize -1<CR>'                        , { desc = "Aumentar tamaño da ventá verticalmente", silent = true})
map( {'n'}     , '<C-Right>'      , ':vertical resize +1<CR>'                        , { desc = "Aumentar tamaño da ventá verticalmente", silent = true})
map( {'i'}     , '<A-b>'          , '()<Left>'                                       , { desc = "Insertar parexa de ()"})
map( {'i'}     , '<A-r>'          , '[]<Left>'                                       , { desc = "Insertar parexa de []"})
map( {'i'}     , '<A-B>'          , '{}<Left>'                                       , { desc = "Insertar parexa de {}"})
map( {'i'}     , '<A-t>'          , '<><Left>'                                       , { desc = "Insertar parexa de <>"})
map( {'i'}     , '<A-q>'          , '""<Left>'                                       , { desc = "Insertar parexa de \"\""})
map( {'i'}     , "<A-'>"          , "''<Left>"                                       , { desc = "Insertar parexa de ''"})
map( {'i'}     , "<A-c>"          , "``<Left>"                                       , { desc = "Insertar parexa de '`"})
map( {'i'}     , '<A-BS>'         , '<BS><Del>'                                      , { desc = "Borrar caracter anterior e seguinte"})
map( {"n"}     , "<leader>1"      , ":set invwrap<CR>"                               , { desc = "Invertir dobreces suaves"})
map( {'n'}     , '<leader>2'      , ":silent lgrep! ''<Left>"                        , { desc = "Xerar lista de erros local"})
map( {'n'}     , '<leader>7'      , ':tjump /'                                       , { desc = "Saltar ao Tag"})
map( {"n"}     , "<leader>9"      , ":let @+=@%<CR>"                                 , { desc = "Nome do ficheiro para o portapapeles", silent = true, remap = false})
map( {"n"}     , "<leader>0"      , ":lopen<CR>"                                     , { desc = "Abrir lista local de erros"})
map( {'v'}     , '<leader>a'   , ':EasyAlign //<Left>'                                                  , { desc = "Aliñar cousas"})

map( {'n'} , '<leader>t'   , function() require('nvim-tree.api').tree.toggle() end, { desc = "Togglear árbore do diretorio"})
map( {'n'} , '<leader>ff'  , function() carga('fzf-lua').files() end                                , { desc = 'Fzf-Lua Ficheiros' })
map( {"n"} , "<leader>fg"  , function() carga('fzf-lua').live_grep() end                            , { desc = "Fzf-Lua Grepea"})
map( {'n'} , '<leader>3'   , function() carga("gitsigns").setloclist() end                          , { desc = "Activar lista de erros locais ca info de git"})
map( {'n'} , '<leader>5'   , function() vim.diagnostic.setloclist() end                             , { desc = "Activar lista de erros locais ca info do LSP"})
map( {'n'} , "<F3>"        , function() carga('deivis.scripts.suxestions').suxerencias() end        , { desc = "Usar Hunspell ca palabra baixo o cursor"})
map( {'n'} , '<F4>'        , function() carga("deivis.scripts.compilacion").lintea() end            , { desc = "Lintear"  , silent = true })
map( {'n'} , '<F5>'        , function() carga("deivis.scripts.compilacion").compila() end           , { desc = "Compilar" , silent = true })
map( {'n'} , "<leader>c"   , function() carga("treesitter-context").go_to_context(vim.v.count1) end , { desc = "Usa treesitter para ir ao comezo do contexto" })
map( {"x"} , "<A-o>"       , function() vim.treesitter.select('prev') end                           , { desc = "Nodo anterior TS"})
map( {"x"} , "<A-i>"       , function() vim.treesitter.select('next') end                           , { desc = "Nodo seguinte TS"})
map( {"x"} , "<A-u>"       , function() vim.treesitter.select('parent') end                         , { desc = "Nodo pai TS"})
map( {"x"} , "<A-p>"       , function() vim.treesitter.select('child') end                          , { desc = "Nodo fillo TS"})
map( {'n'} , '<leader>j'   , function() carga('treesj').join() end                                  , { desc = "Unir árbore"})
map( {'n'} , '<leader>s'   , function() carga('treesj').split() end                                 , { desc = "Separar árbore"})

map(
    {"n"} ,
    "<leader>	"  , -- :NOTA: isto debe ser <leader>TAB, cun TAB literal (-->)
    function()
        if vim.bo.filetype ~= "oil" then carga("oil").open() else carga("oil").close() end
    end,
    { desc = "Abrir explorador de ficheiros aceitoso" }
)

map(
    {"n"},
    "*",
    function()
        vim.fn.setreg("/", [[\V\<]] .. vim.fn.escape(vim.fn.expand("<cword>"), [[/\]]) .. [[\>]])
        vim.fn.histadd("/", vim.fn.getreg("/"))
        vim.o.hlsearch = true
    end,
    { desc = "Mostrar aparicións da palabra baixo o cursor (de justinmk)"}
)

map(
    {'i','v'},
    '<A-e>',
    function()
        if carga('luasnip').expandable() then carga('luasnip').expand() end
    end,
    { desc = 'Expande LuaSnippet' }
)

map(
    {'i','v'},
    '<A-d>',
    function()
        if carga('luasnip').jumpable() then carga('luasnip').jump(1) end
    end,
    { desc = 'Moverse adiante no LuaSnippet' }
)

map(
    {'i','v'},
    '<A-a>',
    function()
        if carga('luasnip').jumpable() then carga('luasnip').jump(-1) end
    end,
    { desc = 'Moverse atrás no LuaSnippet' }
)

map(
    {'i'},
    '<A-w>',
    function()
        if carga('luasnip').choice_active() then carga('luasnip').change_choice(1) end
    end,
    { desc = 'Seleccionar opción seguinte do LuaSnippet' }
)

map(
    {'i'},
    '<A-s>',
    function()
        if carga('luasnip').choice_active() then carga('luasnip').change_choice(-1) end
    end,
    { desc = 'Seleccionar opción anterior do LuaSnippet' }
)

map(
    {'i'},
    '<A-y>',
    function()
        if carga('luasnip').choice_active() then carga("luasnip.extras.select_choice")() end
    end,
    { desc = "Lista de opcións do LuaSnippet" }
)
