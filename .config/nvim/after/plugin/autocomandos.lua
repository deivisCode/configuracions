local grupo = vim.api.nvim_create_augroup("deivis/autocomandos", { clear = true })
local autocomando = vim.api.nvim_create_autocmd

-- Copiado de Folke, creo recordar
autocomando({ "InsertLeave", "WinEnter" }, {
    group = grupo,
    callback = function()
        if vim.w.auto_cursorline then
            vim.wo.cursorline = true
            vim.w.auto_cursorline = nil
        end
    end,
    desc = "Activar cursorline ao sair do modo Insert"
})
autocomando({ "InsertEnter", "WinLeave" }, {
    group = grupo,
    callback = function()
        if vim.wo.cursorline then
            vim.w.auto_cursorline = true
            vim.wo.cursorline = false
        end
    end,
    desc = "Desactivar cursorline ao entrar do modo Insert"
})

autocomando('TextYankPost', {
    group = grupo,
    callback = function() vim.hl.hl_op({ timeout = 250 }) end,
    desc = "Colorear o texto copiado"
})
autocomando('TextPutPost', {
    group = grupo,
    callback = function() vim.hl.hl_op({ timeout = 250 }) end,
    desc = "Colorear o texto pegado"
})

autocomando("TermOpen", {
    group = grupo,
    callback = function()
        vim.o.relativenumber = false
        vim.o.number = false
    end,
    desc = "Non mostrar numeros na terminal"
})

local retardo
autocomando("CmdlineEnter", {
    group = grupo,
    callback = function()
        retardo = vim.uv.new_timer()
        retardo:start(100, 0, vim.schedule_wrap(function()
            if vim.o.number then
                vim.o.relativenumber = false
                vim.api.nvim__redraw({ statuscolumn = true }) -- :NOTA: Ollo, función inestable
            end
        end))
    end,
    desc = "Mostrar números absolutos ao entrar no modo Command"
})
autocomando("CmdlineLeave", {
    group = grupo,
    callback = function()
        if retardo then
            retardo:stop()
            retardo = nil
        end
        if vim.o.number then
            vim.o.relativenumber = true
        end
    end,
    desc = "Mostrar números relativos ao sair no modo Command"
})

autocomando("VimResized", {
    group = grupo,
    command = "wincmd =",
    desc = "Para axustar os tamaños das ventanas ao cambiar o tamaño da terminal"
})

autocomando( "OptionSet", {
    group = grupo,
    pattern = { "listchars", "tabstop", "filetype" },
    callback = function()
        if vim.bo.buftype ~= "" then return end
        require("deivis.scripts.actualiza_linhas").actualiza_linhas()
    end,
    desc = "Actualiza 'listchars' en base a OptionSet"
})
autocomando( "BufEnter", {
    group = grupo,
    callback = function()
        if vim.bo.buftype ~= "" then return end
        require("deivis.scripts.actualiza_linhas").actualiza_linhas()
    end,
    desc = "Actualiza 'listchars' en base a BufEnter"
})

autocomando("BufWinEnter",{
    group = grupo,
    callback = function()
        if vim.o.buftype ~= '' then return end
        vim.fn.matchadd("formato", '\\s\\+$')
        vim.fn.matchadd("formato", '\\($\\n\\s*\\)\\+\\%$')
        vim.fn.matchadd("FACER", ':FACER:')
        vim.fn.matchadd("AQUI", ':AQUI:')
        vim.fn.matchadd("NOTA", ':NOTA:')
    end,
    desc = "Colorear espazos e resaltes especiais"
})
autocomando("TermOpen", {
    group = grupo,
    callback = function()
        vim.fn.clearmatches()
    end,
    desc = "Non mostrar espazos e resaltes especiais"
})

autocomando({'LspAttach', 'ColorScheme'}, {
    group = grupo,
    callback = function(ev)
        vim.lsp.document_color.enable(false, { bufnr = ev.buf })
        for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
            vim.api.nvim_set_hl(0, group, {})
        end
        vim.keymap.set('n', "gd", function() vim.lsp.buf.definition() end)
    end,
    desc = "Cousas LSP: desactivar coloreado e mapeos"
})

autocomando({"LspProgress"}, {
    callback = function(args)
        local value = args.data.params.value or {}
        if value == nil then return end
        local title = value.title
        local percent = value.percentage or 0
        vim.api.nvim_echo(
            {{title}},
            false,
            {
                id      = 'lsp.'..args.data.client_id,
                percent = percent,
                source  = "lsp-progress",
                kind    = "progress",
                title   = "LSP",
                status  = value.kind ~= "end" and "running" or "success"
            }
        )
    end
})
-- local ui2 = require("vim._core.ui2")
-- local msgs = require("vim._core.ui2.messages")
-- local orig_set_pos = msgs.set_pos
-- msgs.set_pos = function(tgt)
--     orig_set_pos(tgt)
--     if (tgt == "msg" or tgt == nil) and vim.api.nvim_win_is_valid(ui2.wins.msg) then
--         pcall(vim.api.nvim_win_set_config, ui2.wins.msg, {
--             relative = "editor",
--             anchor = "NE",
--             row = 1,
--             col = vim.o.columns - 1,
--             border = "single",
--         })
--     end
-- end
