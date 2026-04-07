vim.api.nvim_create_autocmd({'FileType'}, {
    pattern = {'tex'},
    callback = function(event)
        vim.bo.tw = 0
    end,
})
