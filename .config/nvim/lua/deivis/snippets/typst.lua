local funcions = require("deivis.snippets.funcions.funcions")
local ls = require("luasnip")

return {

s(
    {
        trig = "imp",
        name = "import",
        desc = "Importa funcións"
    },
    {
        t('#import("'),i(1),t('"): '),i(2, '*')
    }
),

s(
    {
        trig = "inc",
        name = "include",
        desc = "Inclúe contido"
    },
    {
        t('#include("'), i(1), t('")')
    }
),

s(
    {
        trig = "l",
        name = "let",
        desc = "Define algo"
    },
    {
        t("#let "), i(1), t(" = "), i(2)
    }
),

s(
    {
        trig = "m",
        name = "matematicas",
        desc = "Modo Matemáticas"
    },
    {
        t('$'),i(1),t('$')
    }
),

s(
    { trig = "ex", },
    {
        c(1, {
                sn(nil, { t("BOS DIAS"), i(1) }),
                sn(nil, { t("MALOS DIAS"), i(1) }),
                sn(nil, { t("REGULARES DIAS"), i(1) }),
            }
        )
    }
),

s({ trig = "mt", snippetType = "autosnippet" }, fmta("$<>$ ", { i(1) })),

s(
    { trig = "([^%s]+)E", regTrig = true },
    fmta(
        "(<>)^(<>) ",
        {
            f(function(_, s) return s.captures[1] end),
            i(1)
        }
    )
),

s(
    { trig = "mmt", snippetType = "autosnippet" },
    fmt(
        "$ {} $ ",
        { i(1) }
    )
),

s(
    {
        trig = "ci",
        name = "Cita",
        desc = "Cita cousas"
    },
    {
        t('#cita("'),i(1),t('")')
    }
),

s(
    {
        trig = "def",
        name = "Definicion",
        desc = "Definicion"
    },
    {
        t({'#definicion(',
            '\tnome : "'}),i(1),t({'",',
            '\tancora : "def:'}),i(2),t({'"',')[','\t'}),
                i(3),
            t({'',']'})
    }
),

s(
    {
        trig = "teo",
        name = "teorema",
        desc = "teorema"
    },
    {
        t({'#teorema(',
            '\tnome : "'}),i(1),t({'",',
            '\tancora : "teo:'}),i(2),t({'"',')[','\t'}),
                i(3),
            t({'',']'})
    }
)
}
