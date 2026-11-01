-- :FACER: rematar a puta interface e arranxar os bugs
-- :FACER: en xeral non usar vim.fn
-- :FACER: usar menos parénteses e tal
-- :FACER: usar cousas como hidden, etc.
-- :FACER: usar buftype = ''

local next = next
local funcions = {}

local grupo_status  = vim.api.nvim_create_augroup("deivis/statusline" , {clear = true})
local grupo_winbar  = vim.api.nvim_create_augroup("deivis/winbar"     , {clear = true})
-- local grupo_tabline = vim.api.nvim_create_augroup("tabline_deivis"    , {clear = true})

-- NOME DO FICHEIRO
-- :FACER: esto non se carga ben.
function funcions.nome()

    local ft = vim.bo.filetype
    local bt = vim.bo.buftype

    if vim.bo.buftype ~= '' then
        if bt == "quickfix" then return vim.w.quickfix_title ~= nil and "[qf] "..vim.w.quickfix_title or 'ALGO ANDA MAL'
        elseif bt == "terminal" then return " TERMINAL"
        else return ""
        end
    end

    nome = vim.api.nvim_buf_get_name(0)
    venta = vim.api.nvim_get_current_win()
    bufer = '['..vim.api.nvim_win_get_buf(venta)..']'

    -- :FACER: vim.fs.name (non fn)
    local buffername = vim.fn.fnamemodify(nome,":.")
    if vim.opt.modified:get() then
        return  bufer .. ' ' .. "%#ErrorMsg#" .. buffername .."%#WinBarNC#"
    else
        return  bufer .. ' ' .. "%#WinBarNC#" .. buffername .."%#WinBarNC#"
    end
end


-- DIRECTORIO
function funcions.directorio()
    return "  "..vim.fn.fnamemodify(vim.fn.getcwd(),":t") .. '/ '
end


-- TAMAÑO DO FICHEIRO
-- :FACER: comprobar se e grande e confirmar para abrir
-- bufIsBig = function(bufnr)
--     local max_filesize = 100 * 1024 -- 100 KB
--     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
--     if ok and stats and stats.size > max_filesize then
--         return true
--     else
--         return false
--     end
-- end
function funcions.tamanho_ficheiro()
    if vim.bo.buftype ~= '' then return '' end
    nome = vim.api.nvim_buf_get_name(0)

    -- Nome do ficheiro
    local ficheiro = vim.fn.expand("%:p")
    -- Se está vacío non devolver nada
    if ficheiro == nil or #ficheiro == 0 then return "" end
    -- Tamaño do ficheiro :FACER: usar vim.fs ou uv ou algo (non fn)
    local tamanho = vim.fn.getfsize(ficheiro)
    -- Se é cero ou menor (sus) é que hai algún erro asique mellor dicilo
    if tamanho <= 0 then return "? B " end
    -- Sufixos para os tamaños. Súdama o de kibi ou kilo
    local sufixos = { " B", " KB", " MB", " GB" }

    local i = 1
    while tamanho > 1024 and i < #sufixos do -- #var é a lonxitude de var
        tamanho = tamanho / 1024
        i = i + 1
    end

    local formato = i == 1 and "%d%s" or "%.1f%s"
    return string.format(formato, tamanho, sufixos[i]) .. " "
end


-- DIRTY STATE
function funcions.git()
    if vim.bo.buftype ~= '' then return '' end
    if not (vim.b.gitsigns_head or vim.b.gitsigns_status_dict) then return "" end
    -- Tabla cos datos de git (cambios e tal)
    local dict = vim.b.gitsigns_status_dict
    -- Se algunha parte falta seguramente sea porque o plugin ou ben
    -- fallou ou porque non hai repo de GIT, asique non se devolve nada
    if dict.added == nil or dict.removed == nil or dict.changed == nil or dict.head == nil then return "" end
    local rama = vim.b.gitsigns_head or ""
    local dirty = (dict.added ~= 0 or dict.removed ~= 0 or dict.changed ~= 0) and '*' or ''
    return " "..rama..dirty
end


-- PYTHON VENV
function funcions.venv()
    if (vim.fn.environ()["VIRTUAL_ENV"] == nil) then return "" end
    return ' 󰌠 (%#Morado#'..vim.fn.fnamemodify(vim.fn.environ()["VIRTUAL_ENV"],":t")..'%#Statusline#)'
end


-- Temos treesitter activado?
function funcions.hai_treesitter()
    if vim.bo.buftype ~= '' then return '' end
    return vim.treesitter.get_parser() ~= nil and "  " or ""
end

-- LSP DIAGNOSTICOS
function funcions.diagnostico()
    if vim.bo.buftype ~= '' then return '' end
    if next(vim.diagnostic.get(0)) == nil then return "" end
    local errors   = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN  })
    local info     = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO  })
    local hints    = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT  })
    return
           (errors   > 0 and "%#DiagnosticError#E" .. errors   or "")
        .. (warnings > 0 and "%#DiagnosticWarn#W"  .. warnings or "")
        .. (info     > 0 and "%#DiagnosticInfo#I"  .. info     or "")
        .. (hints    > 0 and "%#DiagnosticHint#H"  .. hints    or "")
        .. "%#WinBarNC#"
end

-- LSP CLIENTES
function funcions.hai_lsp()
    venta = vim.api.nvim_get_current_win()
    bufer = vim.api.nvim_win_get_buf(venta)
    if next(vim.lsp.get_clients({bufnr = bufer})) == nil then return '' end
    return "  "
end

-- Informacion sobre o numero de palabras, caracteres e tal
function funcions.prosa()
    if vim.bo.buftype ~= '' then return '' end
    nome = vim.api.nvim_buf_get_name(0)
    if buffer_terminal(nome) then return "" end
    local datos = vim.fn.wordcount()
    local palabras = datos.words
    local caracteres = datos.chars
    if datos.visual_words ~= nil then
        palabras = datos.visual_words
    end
    if datos.visual_chars ~= nil then
        caracteres = datos.visual_chars
    end
    return '['..palabras..' '..caracteres..']'
end


local modos = {
    ['n'   ] = { '  N  ' , '%#hl_modo_Normal#'  },  -- '    NORMAL    '
    ['i'   ] = { '  I  ' , '%#hl_modo_Insert#'  },  -- '    INSERT    '
    ['R'   ] = { '  R  ' , '%#hl_modo_Replace#' },  -- '   REPLACE    '
    ['no'  ] = { ' N·P ' , '%#hl_modo_Query#'   },  -- '   OP. PEND   '
    ['nov' ] = { ' N·P ' , '%#hl_modo_Query#'   },  -- '   OP. PEND   '
    ['noV' ] = { ' N·P ' , '%#hl_modo_Query#'   },  -- '   OP. PEND   '
    ['niI' ] = { ' I·N ' , '%#hl_modo_Normal#'  },  -- '    INS.NO    '
    ['niR' ] = { ' R·N ' , '%#hl_modo_Normal#'  },  -- '    REP.NO    '
    ['niV' ] = { ' V·N ' , '%#hl_modo_Normal#'  },  -- '    VIS.NO    '
    ['s'   ] = { '  S  ' , '%#hl_modo_Visual#'  },  -- '    SELECT    '
    ['S'   ] = { ' S·L ' , '%#hl_modo_Visual#'  },  -- '    S-LINE    '
    ['v'   ] = { '  V  ' , '%#hl_modo_Visual#'  },  -- '    VISUAL    '
    ['V'   ] = { ' V·L ' , '%#hl_modo_Visual#'  },  -- '    V-LINE    '
    ['vs'  ] = { '  V  ' , '%#hl_modo_Visual#'  },  -- '    VISUAL    '
    ['Vs'  ] = { ' V·L ' , '%#hl_modo_Visual#'  },  -- '    V-LINE    '
    ['Rv'  ] = { ' V·R ' , '%#hl_modo_Replace#' },  -- '  V-REPLACE   '
    ['c'   ] = { '  C  ' , '%#hl_modo_Command#' },  -- '    COMAND    '
    ['cv'  ] = { ' V·E ' , '%#hl_modo_Command#' },  -- '    VIM EX    '
    ['ce'  ] = { '  E  ' , '%#hl_modo_Command#' },  -- '      EX      '
    ['t'   ] = { '  T  ' , '%#hl_modo_Terminal#'},  -- '   TERMINAL   '
    ['nt'  ] = { '  T  ' , '%#hl_modo_Terminal#'},  -- '    N-TERM    '
    ['ntT' ] = { '  T  ' , '%#hl_modo_Terminal#'},  -- '    N-TERM    '
    ['ic'  ] = { '  I  ' , '%#hl_modo_Complete#'},  -- '  COMPLETION  '
    ['ix'  ] = { '  I  ' , '%#hl_modo_Complete#'},  -- '  COMPLETION  '
    ['Rc'  ] = { ' V·R ' , '%#hl_modo_Complete#'},  -- '  COMPLETION  '
    ['Rx'  ] = { ' V·R ' , '%#hl_modo_Complete#'},  -- '  COMPLETION  '
    ['Rvc' ] = { ' V·R ' , '%#hl_modo_Complete#'},  -- '  COMPLETION  '
    ['Rvx' ] = { ' V·R ' , '%#hl_modo_Complete#'},  -- '  COMPLETION  '
    ['r'   ] = { '  P  ' , '%#hl_modo_Query#'   },  -- '    ENTER     '
    ['rm'  ] = { '  M  ' , '%#hl_modo_Query#'   },  -- '     MORE     '
    ['r?'  ] = { '  C  ' , '%#hl_modo_Query#'   },  -- '   CONFIRM    '
    ['!'   ] = { '  E  ' , '%#hl_modo_Query#'   },  -- '   EXEC CMD   '
    [''  ] = { ' V·B ' , '%#hl_modo_Visual#'  },  -- '    V-BLOK    '
    [''  ] = { ' S·B ' , '%#hl_modo_Visual#'  },  -- '    S-BLOK    '
    ['s' ] = { ' V·L ' , '%#hl_modo_Visual#'  },  -- '    V-LINE    '
}


function funcions.modo()
    local modo_actual = vim.api.nvim_get_mode().mode
    return modos[modo_actual][2]..string.format('%s', modos[modo_actual][1])..'%#Statusline#'
end


-- Mostra o ultimo macro grabado, ou o que se está grabando actualmente
function funcions.macros(evento)
    -- no caso de estar deixando de grabar
    if evento == "RecordingLeave" then
        local grabando = vim.fn.reg_recording()
        if grabando == '' then return '' end
        return '@ macro:[%#String#' .. grabando .. '%#Statusline#]'
    -- no caso de estar empezando a grabar
    else
        local grabando = vim.fn.reg_recording()
        return " macro:[%#String#" .. grabando .. '%#Statusline#]'
    end
end


function funcions.pestanha()

    local tabline = ''

    for tab = 1, vim.fn.tabpagenr('$') do -- tabpagenr('$') numero de pestañas
        local win = vim.fn.tabpagewinnr(tab)
        local buf = vim.fn.tabpagebuflist(tab)[win]
        local bufname = vim.fn.bufname(buf)

        tabline = tabline .. (
            tab == vim.fn.tabpagenr() and '%#TabLineSel#' or '%#TabLine#'
        )

        local bufModified = vim.fn.getbufvar(buf, '&mod')
        local ft = vim.fn.getbufvar(buf, '&ft')
        local tabName = ''

        if bufModified == 1 then
            tabName = '+[' .. vim.fn.fnamemodify(bufname, ':t') .. ']'
        else
            tabName = '[' .. vim.fn.fnamemodify(bufname, ':t') .. ']'
        end

        tabline = tabline .. ( bufname ~= '' and tabName or '[baleiro]')
    end

    return tabline

end


-- :FACER: non funciona
function funcions.dobleces()
    local fs = vim.v.foldstart
    local fe = vim.v.foldend
    local start_line = vim.fn.getline(fs):gsub("\t", ("\t"):rep(vim.opt.ts:get()))
    local end_line = vim.trim(vim.fn.getline(fe))
    local spaces = (" "):rep( vim.o.columns - start_line:len() - end_line:len() - 7)
    return start_line .. " > " .. end_line .. spaces
end


function funcions.regra()
    if vim.bo.buftype ~= '' then return '' end
    return "[%7(%l/%3L%):%2v]"
end


function funcions.spell()
    local spell     = vim.o.spell
    local spelllang = vim.o.spelllang
    if spell and spelllang ~= '' then
        return "  (".. spelllang .. ")"
    end
end


function funcions.formato()
    local formato = vim.bo.fileformat
    if formato ~= 'unix' and formato ~= '' then
        return "["..formato.."]"
    else
        return ''
    end
end


function funcions.codificacion()
    local codificacion = vim.bo.fileencoding
    if codificacion ~= "utf-8" and codificacion ~= '' then
        return codificacion.." "
    else
        return ''
    end
end


function funcions.bom()
    if vim.bo.bomb then return "BOM " else return '' end
end


function funcions.cmd()
    return " %#Laranxa#%-5(%S%)%#Statusline# %-5(%{v:prevcount}%{v:operator}%)"
end


function funcions.compilou()
    if vim.g.compilou == nil then return "" end
    if vim.g.erros == 0 then
        return " erros:[%#DiagnosticInfo#" .. vim.g.erros .. "%#Statusline#]"
    end
    if vim.g.compilou == true then
        return " erros:[%#DiagnosticWarn#" .. vim.g.erros .. "%#Statusline#]"
    elseif vim.g.compilou == false then
        return " erros:[%#DiagnosticError#" .. vim.g.erros .. "%#Statusline#]"
    end
end

function funcions.hex()
    return "%#Azul#%o[%04B]%#Statusline#"
end

-- CONSTRUCCION ===============================================================

-- elementos da statusline
local seccions_statusline = {
    funcions.modo()       , -- 1  modo
    funcions.cmd()        , -- 2  ultimo cmd
    ''                    , -- 3  macros
    funcions.hex()        , -- 4  hex code
    funcions.directorio() , -- 5  directorio
    ''                    , -- 6  venv de python
    ''                    , -- 7  git
    ''                    , -- 8  compilou
    '%='                  ,
    ''                    , -- 10  spell
}

-- indices para os elementos da statusline. Logo úsanse estos indices para
-- actualizar a tabla
local elementos_statusline = {
    modo      = 1,
    macros    = 3,
    hex       = 4,
    diretorio = 5,
    venv      = 6,
    git       = 7,
    compilou  = 8,
    spell     = 10,
}

-- Igual pero pa winbar
local seccions_winbar = {
    ''               , -- 1  nome do buffer
    ''               , -- 2  hai treesitter?
    ''               , -- 3  hai lsp?
    ''               , -- 4  diagnostico
    "%=%#WinBarNC#"  ,
    ''               , -- 6  Formato. DOS, UNIX, etc.
    ''               , -- 7  Codificacion. utf-8, latin1, etc.
    ''               , -- 8  Hai BOM?
    ''               , -- 9  tamaño
    ''               , -- 10 prosa
    ''               , -- 11 regra
}

local elementos_winbar = {
    nome           = 1,
    hai_treesitter = 2,
    hai_lsp        = 3,
    diagnostico    = 4,
    formato        = 6,
    codificacion   = 7,
    bom            = 8,
    tamanho        = 9,
    prosa          = 10,
    regra          = 11,
}

local tabline  = '' -- para a tabline, non é unha tabla

-- Funcions pa repintar a statusline ou a winbar. Cada vez que se executa volve
-- a concatenar os elementos da statusline e da winbar. Para o caso da tabline
-- non fai falta concatenar nada porque solo ten un elemento

local repintar_statusline = function() vim.opt.statusline = table.concat(seccions_statusline) end
local repintar_winbar = function() vim.wo.winbar = table.concat(seccions_winbar) end
local repintar_tabline = function() vim.opt.tabline = tabline end

-- chamámolas unha primeira vez
repintar_statusline()
-- repintar_winbar()
-- repintar_tabline()


--[STATUS]-------------------------------------------- cambio de modo

vim.api.nvim_create_autocmd(
    { "ModeChanged" },
    {
        group = grupo_status,
        callback = function(evento)
            seccions_statusline[elementos_statusline.modo] = funcions.modo()
            repintar_statusline()
        end
    }
)

--[STATUS]-------------------------------------------- cambio de diretorio

vim.api.nvim_create_autocmd(
    {"DirChanged"},
    {
        group = grupo_status,
        callback = function()
            seccions_statusline[elementos_statusline.diretorio] = funcions.directorio()
            repintar_statusline()
        end
    }
)

--[STATUS]-------------------------------------------- grabando

vim.api.nvim_create_autocmd(
    { "RecordingEnter", "RecordingLeave" },
    {
        group = grupo_status,
        callback = function(evento)
            seccions_statusline[elementos_statusline.macros] = funcions.macros(evento.event)
            repintar_statusline()
        end
    }
)

--[STATUS]-------------------------------------------- varios

vim.api.nvim_create_autocmd(
    {"SafeState"}, -- :FACER: non me fio deste evento
    {
        group = grupo_status,
        callback = function()
            seccions_statusline[elementos_statusline.compilou] = funcions.compilou()
            seccions_statusline[elementos_statusline.venv] = funcions.venv()
            repintar_statusline()
        end
    }
)

--[STATUS]-------------------------------------------- Git

vim.api.nvim_create_autocmd(
    {"User"}, -- :FACER: non me fio deste evento
    {
        pattern = "GitSignsUpdate",
        group = grupo_status,
        callback = function()
            seccions_statusline[elementos_statusline.git] = funcions.git()
            repintar_statusline()
        end
    }
)

--[STATUS]-------------------------------------------- Spell ou no

vim.api.nvim_create_autocmd(
    { "OptionSet" },
    {
        group = grupo_status,
        pattern = {"spell","spelllang"},
        callback = function()
            seccions_statusline[elementos_statusline.spell] = funcions.spell()
            repintar_statusline()
        end
    }
)

--[WINBAR]-------------------------------------------- info xeral

vim.api.nvim_create_autocmd(
    {
        "BufEnter",
        "BufRead",
        "WinEnter",
        "WinNew",
        "FileChangedRO",
    },
    {
        group = au_winbar,
        callback = function()
            seccions_winbar[elementos_winbar.nome] = funcions.nome()
            seccions_winbar[elementos_winbar.hai_treesitter] = funcions.hai_treesitter()
            seccions_winbar[elementos_winbar.tamanho] = funcions.tamanho_ficheiro()
            seccions_winbar[elementos_winbar.regra] = funcions.regra()
            repintar_winbar()
        end
    }
)
vim.api.nvim_create_autocmd(
    { "OptionSet", },
    {
        group = au_winbar,
        pattern = {"modified"},
        callback = function()
            seccions_winbar[elementos_winbar.nome] = funcions.nome()
            seccions_winbar[elementos_winbar.tamanho] = funcions.tamanho_ficheiro()
            seccions_winbar[elementos_winbar.regra] = funcions.regra()
            seccions_winbar[elementos_winbar.hai_treesitter] = funcions.hai_treesitter()
            repintar_winbar()
        end
    }
)

--[WINBAR]-------------------------------------------- datos do ficheiro

vim.api.nvim_create_autocmd(
    { "OptionSet" },
    {
        group = grupo_winbar,
        pattern = {"fileformat","fileencoding","bomb"},
        callback = function()
            seccions_winbar[elementos_winbar.formato]      = funcions.formato()
            seccions_winbar[elementos_winbar.codificacion] = funcions.codificacion()
            seccions_winbar[elementos_winbar.bom]          = funcions.bom()
            repintar_winbar()
        end
    }
)
vim.api.nvim_create_autocmd(
    { "BufEnter" },
    {
        group = grupo_winbar,
        callback = function()
            seccions_winbar[elementos_winbar.formato]      = funcions.formato()
            seccions_winbar[elementos_winbar.codificacion] = funcions.codificacion()
            seccions_winbar[elementos_winbar.bom]          = funcions.bom()
            repintar_winbar()
        end
    }
)

------------------------------------------------------ diagnostico LSP

vim.api.nvim_create_autocmd(
    {
        "LspAttach",
        "LspTokenUpdate",
        "BufEnter",
        "BufLeave",
        "BufNew",
        "InsertLeave",
        "InsertEnter",
        "SafeState",
    },
    {
        -- group = vim.api.nvim_create_augroup('deivis/status_lspinfo', { clear = true }),
        group = grupo_winbar,
        callback = function()
            seccions_winbar[elementos_winbar.diagnostico] = funcions.diagnostico()
            seccions_winbar[elementos_winbar.hai_lsp] = funcions.hai_lsp()
            repintar_winbar()
        end
    }
)
vim.api.nvim_create_autocmd(
    { "LspDetach" },
    {
        -- group = vim.api.nvim_create_augroup('deivis/status_lspinfo', { clear = true }),
        group = grupo_winbar,
        callback = function()
            seccions_winbar[elementos_winbar.diagnostico] = '' -- Para eliminar os diagnosticos con :lsp stop
            repintar_winbar()
        end
    }
)

------------------------------------------------------ cambio de tabline

vim.api.nvim_create_autocmd(
    { "TabEnter", "TabLeave", "TabNew", "TabNewEntered", "TabClosed" },
    {
        group = au_tabline,
        callback = function()
            tabline = funcions.pestanha() -- :FACER: vai mal ao crear/pechar pestañas
            repintar_tabline()
        end
    }
)


-- Para o caso das dobleces, solo hai que evalualo unha vez. NON FUNCIONA
-- vim.o.foldtext = '%{luaeval("funcions.dobleces()")}'
