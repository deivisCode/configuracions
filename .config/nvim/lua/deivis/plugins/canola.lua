return {

    "https://forge.barrettruth.com/barrettruth/canola.nvim",

    -- branch = "canola",
    -- enabled = false, -- :NOTA: existe ':edit .' #39723

    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        local permission_hlgroups = {
            ['-'] = 'NonText',
            ['r'] = 'Amarelo',
            ['w'] = 'Vermello',
            ['x'] = 'Verde',
        }
        require("oil").setup({
            columns = {
                {
                    "permissions",
                    highlight = function(permission_str)
                        local hls = {}
                        for i = 1, #permission_str do
                            local char = permission_str:sub(i, i)
                            table.insert(
                                hls,
                                { permission_hlgroups[char], i - 1, i }
                            )
                        end
                        return hls
                    end
                },
                "owner",
                "group",
                { 'size', highlight = 'Special' },
                { 'mtime', highlight = 'NonText' },
                "icon",
            },
            view_options = { show_hidden = true, },
            -- constrain_cursor = "name",
            -- constrain_cursor = false,
            watch_for_changes = true,
            keymaps = {
                ["<leader>¡"] = "actions.open_cmdline",
                ["<leader>'"] = "actions.copy_to_system_clipboard"
            }
        })
    end

}
