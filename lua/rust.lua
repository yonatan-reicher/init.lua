vim.api.nvim_create_autocmd({'FileType'}, {
    pattern = {'rust'},
    callback = function(event)
        -- `colorcolumn` is unfortunately cannot be set per-buffer, so we set it
        -- to the current window. Good enough.
        vim.wo.colorcolumn = tostring(vim.bo.textwidth + 1)
    end,
})
