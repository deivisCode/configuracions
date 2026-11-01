vim.diagnostic.config(
    {
        signs = false,
        virtual_text = true,
        -- virtual_lines = true,
        underline = false,
        on_attach = function(client, bufnr)
            vim.keymap.set(
                "n", "<leader>fd",
                function() vim.diagnostic.open_float() end
            )
            vim.keymap.set(
                "n", "<leader>sd",
                function() vim.diagnostic.setloclist() end
            )
        end
    }
)
vim.lsp.enable("tinymist")
vim.lsp.enable("ruff")
vim.lsp.enable("rust-analyzer")
vim.lsp.enable("clangd")
