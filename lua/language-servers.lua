vim.lsp.config('*', {
    root_markers = { '.git' },
})
vim.lsp.config('clangd', {
    cmd = {
        'clangd',
        '--fallback-style=Microsoft',
        '--background-index',
        '--clang-tidy',
        '--offset-encoding=utf-8',
    },
    root_markers = { '.clangd', 'compile_commands.json' },
    filetypes = { 'c', 'cpp' },
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
    'rust_analyzer',
}
local python_lsps = { 'zuban', 'pyright', 'ty' }
for _, lsp in ipairs(python_lsps) do
    if vim.fn.executable(lsp) then
        vim.lsp.enable(lsp)
        break
    end
end
