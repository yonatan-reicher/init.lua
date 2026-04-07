if not moduleExists 'nvim-treesitter' then return end

local languages = {
    "bash",
    "c",
    "lua",
    "rust",
    "nu",
}

local ts = require 'nvim-treesitter'
ts.install(languages):wait(300000)

function get_installed()
    local t = ts.get_installed()
    if vim.list_contains(t, 'latex') then
        table.insert(t, 'tex')
    end
    return t
end

vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    group = vim.api.nvim_create_augroup('my.treesitter.config', { clear = true }),
    callback = function(event)
        local ft = event.amatch
        if not vim.list_contains(get_installed(), ft) then return end
        print(event)
        -- syntax highlighting, provided by Neovim
        vim.treesitter.start()
        -- folds, provided by Neovim
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'
        -- indentation, provided by nvim-treesitter
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
