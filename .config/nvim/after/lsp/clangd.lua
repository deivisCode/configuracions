return {
    cmd = {"clangd-20"},
    filetypes = {"c", "cpp"},
    root_markers = {
        '.git',
        '.clangd'
    },
    capabilities = {
        textDocument = {
            completion = {
                editsNearCursor = true,
            },
        },
        offsetEncoding = { 'utf-8', 'utf-16' },
    },
}
