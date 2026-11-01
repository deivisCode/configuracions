return {

    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },

    config = function()
        require('treesj').setup({
            max_join_length = 500,
            cursor_behaviour = "start",
        })
    end
}
