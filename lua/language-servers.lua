vim.lsp.config('clangd', {
    cmd = { "clangd", "--fallback-style=Microsoft" },
})
vim.lsp.config('rust_analyzer', {
    ['rust-analyzer'] = {
        check = {
            command = 'clippy',
        },
        checkOnSave = {
            enable = true,
            command = 'clippy',
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
