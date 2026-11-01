local M = {}
local next = next

-- Mostra unha mensaxe coloreada co que fixemos.
-- 'titulo': CADEA nome do que facemos, como compilar, filtrar, ou o que sexa
-- 'mensaxe': CADEA mensaxe/comando que rulamos
local function ensina(titulo,mensaxe)
    vim.api.nvim_echo(
        -- O primeiro argumento é unha lista te listas. Cada sub lista ten unha
        -- cadea e un grupo de color. Ao final concaténanse as cadeas cas cores
        -- correspondentes
        {
            { ' ['            , 'Laranxa' } ,
            { titulo          , 'Normal'  } ,
            { ']'             , 'Laranxa' } ,
            { ': ' .. mensaxe , "Normal"  }
        },
        -- engadir a mensaxe ao historial
        false,
        -- opcions que non fan falta
        {}
    )
end

-- [LINTEO] %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

local function lintea(comando, formato)
    -- Gardamos o ficheiro
    vim.cmd("write")
    -- Rulamos o comando de forma SINCRONA, se non, 'lgetfile' ocorre antes de
    -- que acabe o comando (e falla)
    vim.system(comando):wait()
    -- Collemos o ficheiro de erros e abrimolo. Esto depende de que os linters
    -- poidan gardar a info nun documento cun nome específico
    vim.cmd("lgetfile "..formato..".err")
    vim.cmd("lopen")
end

M.lintea = function(ficheiro)

    local ficheiro = vim.fn.expand("%f")
    local linters = {
        ["python"] = {"ruff","check","--quiet","--output-format=pylint","--output-file=python.err",ficheiro},
        ["tex"]    = {"chktex","--quiet","-v0","-n1","-n8","-n36","--inputfiles","--headererr","--output=tex.err",ficheiro}
    }

    -- Gardar os comandos en ftplugin/ con vim.g. e usar eso por defectoç
    for formato,comando in pairs(linters) do
        if vim.bo.filetype == formato then
                lintea(comando, formato)
                ensina("Linter", table.concat(comando,' '))
            return
        end
    end
end

-- [COMPILACION] %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-- :FACER: leer shebangs e poñer ese comando primerio
-- :FACER: separar esto do linteo e do filtrado
-- :FACER: compilar solo a selecion visual
M.compila = function()

    -- Tal vez sexa posible pasar o nome como argumento á función e crear a
    -- táboa de comandos con eso, e aforrámonos re-definilas con cada execución
    local ficheiro = vim.fn.expand("%f")

    -- Valores dos compiladores (ou calquer outro programa) xunto cos tipos de
    -- arquivo.
    local compiladores = {
        ["python"] = {"python3" , ficheiro},
        ["julia"]  = {"julia"   , ficheiro},
        ["tex"]    = {"latexmk" , ficheiro},
        ["typst"]  = {"typst"   , "compile" , "--diagnostic-format" , "short" , "--root", ".", "--pdf-standard","2.0", ficheiro },
        ["json"]   = {"make"}
    }

    -- Iteramos pola lista anterior
    for formato,comando in pairs(compiladores) do

        -- Cando atinamos, é cando facemos cousas
        if vim.bo.filetype == formato then

            -- Gardamos o ficheiro
            vim.cmd("write")

            -- Probamos a usar o ultimo comando gardado, se o hai. Esto sirve
            -- para que se cambiamos o comando en vim.input, a próxima vez nos
            -- mostre o novo
            if vim.g.ultimo_comando ~= nil then
                comando = vim.g.ultimo_comando
            end

            local novo_comando = {}

            -- Pedimos input na cmdline
            vim.ui.input(
                {
                    prompt = "[COMPILAR]: ",
                    -- Por defecto, mostramos 'comando', que é o da taboa
                    -- anterior OU ultimo_comando. Hai que concatenar porque
                    -- esto debe ser unha cadea e non unha taboa
                    default = table.concat(comando,' ')
                },
                -- Ao aceptar, qué facemos. Volvemos obter unha taboa da cadea,
                -- a cal podemos editar. Saquei a idea de Emacs.
                function(input)
                    -- Se non seleccionamos nada
                    if input == nil then
                        ensina("NADA SELECCIONADO",'')
                        -- Rematamos
                        return
                    end
                    -- Contruimos o novo comando a partir do que metésemos en
                    -- vim.input, separando en espazos en blanco
                    for cadea in string.gmatch(input,'[^ ]+') do
                        table.insert(novo_comando, cadea)
                        -- E gardámolo na lista para gardalo logo
                        -- :FACER: tal vez usar vim.b/w ?
                        vim.g.ultimo_comando = novo_comando
                    end
                end
            )

            -- Funcion para executar cando remata vim.system()
            local function na_salida(obj)
                -- Se foi ben
                if obj.code == 0 then
                    vim.schedule_wrap(ensina)("COMPLETADO", table.concat(novo_comando, ' '))
                    -- Xeramos unha qflist
                    vim.schedule_wrap(vim.fn.setqflist)(
                        {},
                        ' ',
                        -- :FACER: separar a cadea mellor
                        { lines = vim.split(obj.stderr, "\n") }
                    )
                    vim.g.compilou = true
                    vim.g.erros = #vim.split(obj.stderr, "\n") - 1
                -- Se foi mal
                else
                    vim.schedule_wrap(ensina)("ALGO FALLOU no schedule wrap", table.concat(novo_comando, ' '))
                    vim.schedule_wrap(vim.fn.setqflist)(
                        {},
                        ' ',
                        { lines = vim.split(obj.stderr, "\n") }
                    )
                    vim.g.compilou = false
                    vim.g.erros = #vim.split(obj.stderr, "\n") - 1
                end
                return
            end
            -- NOTA: fai falta vim.schedule_wrap porque 'na_salida' é, por
            -- construcción, de tipo 'fast-api', polo que dentro desta función
            -- non se poden chamar outras que non o son, a menos que as metamos
            -- nun 'schedule'. Está malamente explicado na documentación de
            -- ditas funcións

            -- Temos o comando que seleccionamos con vim.input, e a funcion
            -- para executar cando remate de rular o comando. Só queda
            -- executalo
            if next(novo_comando) == nil then
                return
            else
                local executacion = vim.system( novo_comando, na_salida )

                -- Damos info
                ensina("Rulando", table.concat(executacion.cmd, ' ' ))
            end

            -- Alternativa parralleira a usar vim.system:
            -- io.popen(table.concat(novo_comando, ' ') .. " 2> " .. formato .. ".err " .. " 1>/dev/null")

            return
        end
    end
end

return M
