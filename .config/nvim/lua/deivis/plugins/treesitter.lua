return {

    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter-context" },
    build = ":TSUpdate",

    config = function()

        -- disable = function(lang, buf)
        --     local max_filesize = 100 * 1024   -- 100 KB
        --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        --     if ok and stats and stats.size > max_filesize then return true end
        -- end,

        require("nvim-treesitter").install({
            "bibtex"     ,
            "bash"       ,
            "c"          ,
            "cpp"        ,
            "csv"        ,
            "diff"       ,
            "dot"        ,
            "json"       ,
            "jq"         ,
            "latex"      ,
            "lua"        ,
            "make"       ,
            "python"     ,
            "julia"      ,
            "just"       ,
            "sql"        ,
            "query"      ,
            "vim"        ,
            "vimdoc"     ,
            "powershell" ,
            "rust"       ,
            "make"       ,
            "cmake"      ,
            "gpg"        ,
            "markdown"   ,
            "typst"      ,
            "yaml"       ,
            "html"       ,
            "xml"        ,
            "javascript" ,
            "regex"      ,
            "haskell"
        })
        require("treesitter-context").setup({
            max_lines         = 5,
            min_window_height = 30,
            separator         = '┄',
            -- mode              = "topline"
        })
    end
}
