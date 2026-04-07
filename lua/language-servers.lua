vim.lsp.config('clangd', {
    cmd = { "clangd", "--fallback-style=Microsoft" },
})
vim.lsp.config('rust_analyzer', {
    settings = {
        ['rust-analyzer'] = {
            check = {
                enable = true,
                command = 'clippy',
                features = 'all',
            },
            checkOnSave = true,
        },
    },
})
vim.lsp.enable {
    'clangd',
    'csharp_ls',
    'dafny',
    'elmls',
    'fsautocomplete',
    'pyright',
    'rust_analyzer',
}
