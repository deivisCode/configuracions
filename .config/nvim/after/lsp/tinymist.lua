return {
    cmd = {"tinymist"},
    filetypes = {"typst"},
    root_markers = { '.git' },
    -- :FACER: mirar isto en detalle, e igual metelo en mapeos.lua ou
    -- comandos.lua ou en lsp.lua
    on_attach = function(client, bufnr)
        vim.lsp.completion.enable(true, client.id, bufnr, {
            autotrigger = true,
            convert = function(item)
                return { abbr = item.label:gsub("%b()", "") }
            end,
        })
        vim.keymap.set(
            "i", "<C-space>",
            vim.lsp.completion.get,
            { desc = "trigger autocompletion" }
        )
        vim.api.nvim_create_user_command(
            "TypstPin",
            function()
                client:exec_cmd(
                    {
                        title = "pin",
                        command = "tinymist.pinMain",
                        arguments = { vim.api.nvim_buf_get_name(0) },
                    },
                    { bufnr = bufnr }
                )
            end,
            {}
        )
        vim.api.nvim_create_user_command(
            "TypstUnPin",
            function()
                client:exec_cmd(
                    {
                        title = "UnPin",
                        command = "tinymist.pinMain",
                        arguments = { vim.v.null },
                    },
                    { bufnr = bufnr }
                )
            end,
            {}
        )
    end
}
