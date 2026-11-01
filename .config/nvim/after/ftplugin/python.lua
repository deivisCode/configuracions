vim.opt_local.tabstop = 4
vim.opt.shiftwidth = 0

vim.opt_local.errorformat = '%f:%l: %m'
vim.treesitter.start()
vim.opt_local.formatprg = "ruff format -q -"
