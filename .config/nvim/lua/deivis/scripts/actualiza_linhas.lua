local M = {}

function M.actualiza_linhas()

    -- Os caracteres
    local lcs = vim.opt_local.listchars:get()

    -- O leadmultispace, no meu caso uso algo '┊   '
    local tab = vim.fn.str2list(lcs.leadmultispace)
    local lead = {tab[1]} -- O primeiro caracter

    -- O espazo para separar os marcadores
    local space = vim.fn.str2list(lcs.multispace or lcs.space)


    for i = 1, vim.bo.tabstop-1 do
        lead[#lead+1] = space[i % #space + 1]
    end

    vim.opt_local.listchars:append({ leadmultispace = vim.fn.list2str(lead) })

end

return M
