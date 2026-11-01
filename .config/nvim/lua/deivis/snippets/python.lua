return {

s('f', {
    t("for ")   , i(1,'i'), t(' in '), i(2), t(':'),
    t({'','\t'}), i(0,"pass")
}),

s('w', {
    t("while ")   , i(1,'i'), t(':'),
    t({'','\t'}), i(0,"pass")
}),

s('v', {
    i(1), t(" = plt.figure("),i(2),t(')')
}),

s('l', {
i(1,"lenzo"),t(" = "),i(2),t(".add_subplot("),i(3,"1"),t(','),i(4,'1'),t(','),i(5,'1'),t(')')
}),

s("rl",{
t("range(len("),i(1),t("))")
}),


s('arr',     { t("np.array(") , i(1), t(")")          }) ,
s("imp",     { t("import ")   , i(1), t(" as "), i(2) }) ,
s("imports", { t({
    "import numpy as np",
    "import matplotlib.pyplot as plt",
    "import scipy.optimize as sco",
    "import scienceplots",
    "",
    "plt.style.use('science')"
}) }),
s("fs",      { t('f"')        , i(1), t('"')          }) ,

s("debug",   {
    t({'print("DEBUG===============================================")','print('}),
    i(1),
    t({')', 'print("DEBUG===============================================")'})
})

}
