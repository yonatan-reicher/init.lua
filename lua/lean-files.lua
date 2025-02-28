-- NOTE: This file is not named lean.lua because it conflicts with the plugin name for lean.

-- TODO: Move require('lean') for the lean plugin to this file.
-- TODO: Think about using a file type plugin (:help ftplugin)

vim.api.nvim_create_autocmd({"BufRead"}, {
    pattern = {"*.lean"},
    callback = function(event)
        -- vim.wo is for window-scoped options
        vim.wo.spell = false
    end,
})
