return {

    "L3MON4D3/LuaSnip",
    lazy = true,
    build = "make install_jsregexp",

    config = function()

        local ls = require('luasnip')
        local types = require('luasnip.util.types')

        ls.setup({
            enable_autosnippets = true,
            update_events = { 'TextChanged', 'TextChangedI' },
            ext_opts = {
                [types.insertNode] = { active = { virt_text = {{"<--", "Amarelo"}} } },
                [types.choiceNode] = { active = { virt_text = {{"??", "Laranxa"}} } },
            }
        })

        ls.filetype_extend("json", {"typst"})

        --[[
            Engádense snippets con ls.add_snippet("all", { s(...), s(...) })
            Snippets:
                Luasnip : s("...", { t(..), d(...), ... })
                FMT     : s("...", { fmt("{1} ... {2}", { s(...), s(...) }) })
                LSP     : ls.parser.parse_snippet({trig = "trig"}, "...")
                SNIPMATE: ls.parser.parse_snipmate({trig = "trig"}, "...")
            Carga:
                require("luasnip.loaders.from_{lua,vscode,snipmae}").lazy_load({paths=...})     -- all.lua, typst.lua
                    vscode   -> .json   (precisa o package.json). Exemplos: https://github.com/rafamadriz/friendly-snippets 
                    snipmate -> .snippet                          Exemplos: https://github.com/honza/vim-snippets
        ]]
        require("luasnip.loaders.from_lua").lazy_load( { paths = {"./snippets"} })
        require("luasnip.loaders.from_vscode").lazy_load( { paths = {"./snippets"} })

    end
}
