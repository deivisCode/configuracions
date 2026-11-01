local M = {}

function M.copy(args) return args[1] end
function M.uuid() return vim.fn.strftime('%Y%m%dT%H%M%S') end
function M.time() return vim.fn.strftime('%H:%M') end
function M.date() return vim.fn.strftime('%d-%m-%Y') end
function M.rdate() return vim.fn.strftime('%A %e, %B(%m) %Y') end

-- change text to lowercase, no tildes and '_' instead fo whitespaces
function M.alias(args)
    -- change whitespaces to underscores and lowercase all
    local word = vim.fn.substitute(vim.fn.tolower(args[1][1]), ' ', '_', 'g')
    -- characters with tildes and corresponding substitutions
    local characters = {
        ['á'] = 'a',
        ['é'] = 'e',
        ['í'] = 'i',
        ['ó'] = 'o',
        ['ú'] = 'u',
        ['ñ'] = 'nh',
        ['('] = '',
        [')'] = '',
        [','] = ''
    }
    -- 'char' for indexing and 'rep' for replacement
    for char,rep in pairs(characters) do
        word = vim.fn.substitute(word,char,rep,'g')
    end
    return word
end

return M
