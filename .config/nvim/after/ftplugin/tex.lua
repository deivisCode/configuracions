vim.opt.indentexpr = ''
vim.opt.shiftwidth = 0

vim.opt_local.formatprg = "tex-fmt --stdin --tabsize 4 2> /dev/null"

-- vim.opt_local.keywordprg = "texdoc --nointeract"

vim.opt_local.tabstop = 4
vim.wo.breakindentopt = 'shift:6' -- as sobladas están desplazadas
vim.wo.wrap = true -- dobleces
vim.wo.breakindent = true -- liñas dobladas continuan indentadas
vim.treesitter.start()
