
local M = {}

local function completado()
    local palabra = vim.fn.expand("<cword>")
    local resultados = vim.fn.systemlist(
        "echo '" .. palabra .. "' | ~/.deivis_scripts/galego_rep.sh"
    )
    return resultados
end

function M.suxerencias()

    local suxerencias = completado()

    -- Comprobar se hai suxerencias
    if next(suxerencias) == nil then
        vim.print("Sin suxerencias")
        return
    end

    vim.print(suxerencias)

    -- Seleccionar unha suxerencia
    vim.ui.select(
        suxerencias,
        { prompt = "Suxestión?" },
        function(choice)
            if choice == nil then return end
            -- local cursor_pos = vim.api.nvim_win_get_cursor(0)
            vim.cmd("norm viw")
            vim.api.nvim_paste(choice,false, -1)
            -- vim.cmd(":call cursor(" .. cursor_pos[1] .. ", " .. cursor_pos[2] + 1 .. ")")
        end
    )

end

return M

-- Copia do arquivo de arriba de bash
--
-- #!/usr/bin/bash
--
-- while read input; do
--     if [ -n "$input" ]; then
--         resultados=$(
--         echo "$input" | \
--             hunspell -d "$HOME/deivis_datos/recursos/codigo/diccionarios/gl" | \
--                 grep "^&"       | \
--                 cut -d ":" -f 2 | \
--                 sed 's/,//g'    | \
--                 xargs echo      | \
--                 sed 's/ /\n/g'
--     )
--     fi
-- done < "${1:-/dev/stdin}"
--
-- [ -n "$resultados" ] && echo -e "$resultados"
