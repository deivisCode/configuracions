return{ 'lewis6991/gitsigns.nvim',

    -- :FACER: perfilar todo cos timings de neovim
    -- lazy = true,
    -- cmd = {"Gitsigns"},

    config = function()

        require('gitsigns').setup({
            numhl      = false,
            -- linehl     = true,
            signcolumn = false,
            current_line_blame_opts = {
                virt_text     = true,
                virt_text_pos = 'eol',
                delay         = 100,
            },
            current_line_blame_formatter = '[<abbrev_sha>], <author_time:%X %x> - <summary>',
        })

    end

}
