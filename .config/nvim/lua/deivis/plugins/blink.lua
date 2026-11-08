return {

    'saghen/blink.cmp',
    version = '1.*',
    build = 'cargo build --release',
    dependencies = {
        { 'Kaiser-Yang/blink-cmp-git', },
        { 'disrupted/blink-cmp-conventional-commits' },
    },

    opts = {

        enabled = function() return vim.tbl_contains({'typst', 'gitcommit'}, vim.bo.filetype) end,
        completion = {
            keyword    = { range = 'prefix' },
            accept     = { auto_brackets = { enabled = false }, },
            list       = { selection = { preselect = true, auto_insert = true } },
            menu       = { border = "single", winblend = 20, scrollbar = false},
            ghost_text = { enabled = true },
            documentation = { auto_show = true, auto_show_delay_ms = 500, window = { border = "single", max_width = 60, scrollbar = false} }
        },
        signature  = { enabled = true },
        fuzzy = { implementation = "rust" },
        cmdline = { enabled = false },
        sources = {
            default = {
                'lsp',
                'path',
                'buffer',
                'git',
                'conventional_commits',
            },
            providers = {
                lsp = { min_keyword_length = 3 },
                path = { min_keyword_length = 3 },
                buffer = { min_keyword_length = 3 },
                git = {
                    module = "blink-cmp-git",
                    name = "Git",
                    enabled = function() return vim.tbl_contains({ 'gitcommit' }, vim.bo.filetype) end,
                },
                conventional_commits = {
                    name = "Conventional Commits",
                    module = "blink-cmp-conventional-commits",
                    enabled = function() return vim.bo.filetype == 'gitcommit' end,
                    opts = {
                        completion = {
                            items = {
                                { type = "novo",        doc = "Engadir unha nova funcionalidade, capitulo ou sección."},
                                { type = "traballo",    doc = "Continuar escribindo contido xenérico."},
                                { type = "apaño",       doc = "Corrección dun bug ou errata."},
                                { type = "docs",        doc = "Cambios na documentación (README, comentarios, etc.)."},
                                { type = "estilo",      doc = "Cambios no estilo visual dos apuntes."},
                                { type = "orde",        doc = "Reestruturación do código sen engadir funcionalidades nin corrixir bugs."},
                                { type = "rendemento",  doc = "Melloras no rendemento."},
                                { type = "compilacion", doc = "Cambios que afectan o sistema de compilación ou dependencias externas."},
                                { type = "tarefa",      doc = "Tarefas de mantemento que non afectan ao código principal (scripts, hooks, .gitignore, etc.)."},
                                { type = "tornar",      doc = "Reverter un commit anterior."}
                            }
                        }
                    }
                }
            }
        }
    },
    opts_extend = { "sources.default" }
}
