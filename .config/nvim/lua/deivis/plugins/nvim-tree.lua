return { 'nvim-tree/nvim-tree.lua',

    lazy = false,

    dependencies = {"nvim-tree/nvim-web-devicons"},

    config = function()

        require("nvim-tree").setup {
            hijack_cursor = true, -- keep cursor in first letter of the tree
            view = {
                side = "right",
                signcolumn = "no",
                width = "20%"
            },
            renderer = {
                highlight_opened_files = "name",
                indent_markers = { enable = false },
                icons = {
                    show   = { modified = false, },
                    glyphs = {
                        folder = {
                            arrow_closed = '',
                            arrow_open = ''
                        },
                    }
                },
                symlink_destination = false,
            },
            git = { enable = false },
            update_focused_file = { enable = true, },
            modified = { enable = false, },
            actions = { expand_all = { exclude = {'.git'} }, },
            live_filter = { always_show_folders = true },
        }
    end
}
