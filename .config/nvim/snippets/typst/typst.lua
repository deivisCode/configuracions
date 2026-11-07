local ls = require("luasnip")


return {

    s(
        { trig = "imp", name = "import", desc = "Importa funcións" },
        fmt('#import("{}"): {}', {i(1),i(2,"*")} )
    ),

    s(
        { trig = "inc", name = "include", desc = "Inclúe contido" },
        fmt('#include("{}")', {i(1)})
    ),

    s(
        { trig = "l", name = "let", desc = "Define algo" },
        fmt('#let {} = {}', {i(1), i(2)})
    ),

    s(
        { trig = "i¡", snippetType = "autosnippet", name = "inline math", desc = "Entrar no modo inline math" },
        fmt( "${}$"  , { i(1) })
    ),

    s(
        { trig = "d¡", snippetType = "autosnippet", name = "display math", desc = "Entrar no modo display math" },
        fmt( "$ {} $", { i(1) })
    ),

    s(
        { trig = "b¡", snippetType = "autosnippet", name = "display math multiline", desc = "Entrar no modo display math, en varias liñas" },
        fmt( "$\n\t{}\n$", { i(1) })
    ),

    s(
        { trig = "ci", name = "Cita", desc = "Cita cousas" },
        fmt('#cita("{}")', {i(1)})
    ),

    s(
        { trig = "def", name = "definicion", desc = "definicion" },
        fmt([[
            #definicion(
                nome: "{}",
                ancora: "def:{}",
            )[
                {}
            ]
        ]],
            { i(1), i(2), i(3) }
        )
    ),

    s(
        { trig = "teo", name = "teorema", desc = "teorema" },
        fmt([[
            #teorema(
                nome: "{}",
                ancora: "teo:{}",
            )[
                {}
            ]
        ]],
            { i(1), i(2), i(3) }
        )
    ),
    -- s(
    --     { trig = "b¡", snippetType = "autosnippet", name = "display math multiline", desc = "Entrar no modo display math, en varias liñas" },
    --     fmt( "$\n\t{}\n$", { i(1) })
    -- ),



}
