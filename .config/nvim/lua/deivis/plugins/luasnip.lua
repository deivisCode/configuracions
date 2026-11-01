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

            -- Algo experimtenal, poden usarse ext_marks, e podemos colorear
            -- con calquer grupo, ou engadir texto virtual. Poñendoo aquí val
            -- para todos os snippets, ou podemos engadilo a cada snippet como
            -- ultimo argumento, tipo node_etx_opts = { active = {...}}
            -- ext_opts = {
            --     [types.insertNode] = {
            --         active = { virt_text = {{"I", "Amarelo"}}},
            --     },
            --     [types.choiceNode] = {
            --         active = { virt_text = {{"C", "Laranxa"}}},
            --     },
            -- }

        })

        -- :FACER: pasalos a strings típicas, máis lexible
        -- require("luasnip.loaders.from_{vscode,snipmate,lua}")
        -- Os de lua pode meterselle ls.fmta("a <> b") dentro (devolve táboa con nodos)
        -- parsers de snipptes tipo LSP
        -- ls.parser.parse_snippet({trig = "lsp"}, "$1 is ${2|hard,easy,challenging|}")
        -- ls.parser.parse_snipmate("year", "The year is `strftime('%Y')`")
        require("luasnip.loaders.from_lua").lazy_load( { paths = "./lua/deivis/snippets" })

    end
}
