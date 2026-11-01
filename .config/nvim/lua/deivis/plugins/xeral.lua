return {
    { 'tpope/vim-fugitive'      , cmd   = {'Git'} },
    { 'uga-rosa/ccc.nvim'       , cmd   = {'CccPick', 'CccHighlighterToggle'}, config = true },
    { 'junegunn/vim-easy-align' , cmd   = {'EasyAlign'} },
    { 'kylechui/nvim-surround'  , event = {'CursorMoved'}, config = true },
    { 'tpope/vim-characterize'  , key   = {'ga'}},
    -- { 'stevearc/aerial.nvim'    , opts = {}, dependencies = {"nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons"} },
    { "hedyhli/outline.nvim"    , lazy = true, cmd = { "Outline", "OutlineOpen" }, opts = { }, },
    -- { "Fildo7525/pretty_hover", event = "LspAttach", opts = {} ,}

}
