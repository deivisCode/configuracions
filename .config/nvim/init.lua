--[[
 _____  ______ _______      _______  _____   _   ___      _______ __  __ _____   _____
|  __ \|  ____|_   _\ \    / /_   _|/ ____| | \ | \ \    / /_   _|  \/  |  __ \ / ____|
| |  | | |__    | |  \ \  / /  | | | (___   |  \| |\ \  / /  | | | \  / | |__) | |
| |  | |  __|   | |   \ \/ /   | |  \___ \  | . ` | \ \/ /   | | | |\/| |  _  /| |
| |__| | |____ _| |_   \  /   _| |_ ____) | | |\  |  \  /   _| |_| |  | | | \ \| |____
|_____/|______|_____|   \/   |_____|_____/. |_| \_|   \/   |_____|_|  |_|_|  \_\\_____|

]]

vim.cmd("colorscheme deivis_escuro")

-- Función para facer 'require' de forma segura
function carga(paquete)
    local foi_ok, resultado = pcall(require, paquete)
    if foi_ok then return resultado end
    vim.notify(
        "Cajáchela cargando [" .. paquete .. "]\n".. resultado,
        vim.log.levels.ERROR
    )
end

-- cargar UI2
carga("vim._core.ui2").enable({
    enable = true,
    msg = {
        targets = {
            [""]         = "msg",
            bufwrite     = "msg",
            completion   = "cmd",
            confirm      = "cmd",
            echo         = "msg",
            echoerr      = "pager",
            echomsg      = "msg",
            empty        = "cmd",
            emsg         = "pager",
            list_cmd     = "pager",
            lua_error    = "pager",
            lua_print    = "msg",
            progress     = "pager",
            quickfix     = "msg",
            rpc_error    = "pager",
            search_cmd   = "cmd",
            search_count = "cmd",
            shell_cmd    = "pager",
            shell_err    = "pager",
            shell_out    = "pager",
            shell_ret    = "msg",
            typed_cmd    = "cmd",
            undo         = "msg",
            verbose      = "pager",
            wildlist     = "cmd",
            wmsg         = "msg",
        },
        dialog   = { height = 0.5   } ,
        pager    = { height = 0.999 }
    }
})

-- Esto é pa non cargar os proveedores de distintas linguaxes, total non os uso
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider    = 0
vim.g.loaded_node_provider    = 0
vim.g.loaded_perl_provider    = 0

-- Sistema de plugins -------------------------------------------------------

-- Bootstrap para lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

-- configuracion de lazy

require("lazy").setup({
    performance = {
        rtp = {
            -- desactivar algunhas cousas
            disabled_plugins = {
                "matchit",
                "matchparen",
                "netrwPlugin",
                "rplugin",
                "spellfile",
                "tarPlugin",
                "tutor",
            },
        },
    },
    change_detection = { enabled = false },
    ui = {
        border = 'rounded',
        wrap   = false,
        title  = ' Lazy ',
    },
    spec  = { { import = 'deivis.plugins' } }, -- este é o diretorio onde están todos os plugins
    rocks = { enabled = false }
})
