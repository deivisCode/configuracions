local funcions = require("deivis.snippets.funcions.funcions")

return {

s('use', { t('\\usepackage{'),i(1),t('}') }),

s('beg', {

    c(1,{
        sn(nil,{
            t('\\begin{'),i(1),t({'}',''}),
            i(2),
            t({'','\\end{'}),f(funcions.copy,1),t('}')
        }),
        sn(nil,{
            t('\\begin{'),i(1),t({'*}',''}),
            i(2),
            t({'','\\end{'}),f(funcions.copy,1),t('*}')
        })
    })
}),

s('doc'   , { t('\\documentclass{') , i(1) , t('}')                  }) ,
s('em'    , { t('\\emph{')          , i(1) , t('}')                  }) ,
s('it'    , { t('\\textit{')        , i(1) , t('}')                  }) ,
s('bf'    , { t('\\textbf{')        , i(1) , t('}')                  }) ,
s('tt'    , { t('\\texttt{')        , i(1) , t('}')                  }) ,
s('sec'   , { t("\\section{")       , i(1) , t('}')                  }) ,
s('ssec'  , { t("\\subsection{")    , i(1) , t('}')                  }) ,
s('sssec' , { t("\\subsubsection{") , i(1) , t('}')                  }) ,
s('par'   , { t("\\paragraph{")     , i(1) , t('}')                  }) ,
s('in'    , { t('\\(')              , i(1) , t('\\)')                }) ,
s('dis'   , { t({'\\[', ''})        , i(1) , t({'','\\]'})           }) ,
s('fra'   , { t('\\frac{')          , i(1) , t('}{') , i(2) , t('}') }) ,
s('link'  , { t('\\link{')          , i(1) , t('}{') , i(2) , t('}') }) ,

s("del", {
    c(1,{
        sn(nil,{ t('\\left( ')        , i(1) , t(' \\right)'        )}),
        sn(nil,{ t('\\left[ ')        , i(1) , t(' \\right]'        )}),
        sn(nil,{ t('\\left\\{ ')      , i(1) , t(' \\right\\}'      )}),
        sn(nil,{ t('\\left\\langle ') , i(1) , t(' \\right\\rangle' )})
    })
}),

s("figure", {
    t({
    "\\begin{figure}[H]",
        "\t\\begin{center}",
            "\t\t\\includegraphics[scale="}), i(1,'1'),t(']{'),i(2,"ruta\\"),t({'}',''}),
          t("\t\t\\caption{"),i(3,"Imaxe bonita"),t({'}',''}),
          t("\t\t\\label{fig:"),i(4,"figura"),t({'}',''}),
     t({"\t\\end{center}",
   "\\end{figure}"}),
}),

s(
    {
        trig = "l",
        name = "Label",
        desc = "Label"
    },
    {
        c(1,    {
            sn(nil, { t("\\label{fig:")   , i(1), t("}") }),
            sn(nil, { t("\\label{tab:")   , i(1), t("}") }),
            sn(nil, { t("\\label{par:")   , i(1), t("}") }),
            sn(nil, { t("\\label{cap:")   , i(1), t("}") }),
            sn(nil, { t("\\label{sec:")   , i(1), t("}") }),
            sn(nil, { t("\\label{ssec:")  , i(1), t("}") }),
            sn(nil, { t("\\label{sssec:") , i(1), t("}") })
        })
    }
),

-- Véxase https://github.com/L3MON4D3/LuaSnip/wiki/Misc#dynamicnode-with-user-input
s(
    "tab",
    fmt(
        [[
        \begin{{tabular}}{{{}}}
        {}
        \end{{tabular}}
        ]],
        {
            i(1, "c"),
            d(2, funcions.tab, {1}, {
                user_args = {
                    function(snip) snip.rows = snip.rows + 1 end,
                    function(snip) snip.rows = math.max(snip.rows - 1, 1) end
                }
            })
        }
    )
)

}
