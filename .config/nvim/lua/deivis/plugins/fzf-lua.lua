return {

    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = {"FzfLua"},

    config = function()
        require("fzf-lua").setup({
            winopts = {
                border = {"", " ", "", "", "","","",""},
                preview = {
                    layout = "vertical",
                    border = {"", "-", "", "", "","","",""},
                },
                fullscreen = true,
            },
            previewers = { builtin = { syntax_limit_b = 1024 * 100 } },
            oldfiles = { include_current_session = true },
            grep = {
                rg_glob        = true,
                glob_flag      = "--iglob",
                glob_separator = "%s%-%-",
                rg_opts        = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --multiline -e",
            },
            files = {
                cwd_prompt = false,
                prompt     = "   ",
                fd_opts    = [[--color=never --type f --hidden --follow --exclude .git --exclude snap]],
            },
        })
    end

}
