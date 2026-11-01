local comando = vim.api.nvim_create_user_command

comando(
    'Trim',
    function()
        vim.cmd [[%s/\s\+$//e]] -- eliminar espazos finais
        vim.cmd [[%s/\n\+\%$//e]] -- eliminar liñas finais
    end,
    { desc = "Elimina espazos en branco e liñas finais" }
)

comando(
    "Snip",
    function()
        require("luasnip.loaders").edit_snippet_files()
    end,
    { desc = "Edita snippets de Luasnip rapidamente"}
)

comando("Spell",
    function()
        vim.cmd("set spelllang=gl")
        vim.cmd("set spell")
    end,
    { desc = "Activa a corrección gramatical" }
)

-- :FACER: usar vim.system()
comando(
    "PDF",
    function()
        vim.cmd[[silent exec "!zathura --fork " . expand("%:p:r") . ".pdf &"]]
    end,
    { desc = "Abre o ficheiro PDF actual" }
)
