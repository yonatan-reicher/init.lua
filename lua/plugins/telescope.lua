t = require('telescope')

t.setup {
    defaults = {
        layout_strategy = 'horizontal',
        scroll_strategy = 'limit',
        layout_config = {
            preview_cutoff = 0,
            center = {
            },
        },
    },
}

-- Telescope bingings.
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>fF', ':Telescope<CR>', {})