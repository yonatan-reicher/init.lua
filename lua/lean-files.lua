-- NOTE: This file is not named lean.lua because it conflicts with the plugin
-- name for lean.

-- TODO: Move require('lean') for the lean plugin to this file.

vim.api.nvim_create_autocmd('FileType', {
    desc = 'Lean file options',
    pattern = {'lean'},
    group = vim.api.nvim_create_augroup('lean-file-options', { clear = true }),
    callback = function(args)
        buf = args.buf
        -- This is a nicer comment string in my opinion.
        vim.bo[buf].commentstring = '-- %s'
        -- Disable spell checking in Lean files, since it is not very useful.
        -- Spell checking is a window-local option, we can't set it per-buffer,
        -- so we just set it for the current window.
        vim.wo.spell = false
        vim.bo[buf].tw = 100
        vim.wo.colorcolumn = '101'
    end,
})
