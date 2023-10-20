-- The main leader key will be space.
vim.g.mapleader = ' '

-- Use :Date to insert the current date.
vim.api.nvim_create_user_command('Date', "normal a<C-R>=strftime('%Y-%m-%d')<CR><ESC>", {
    desc = 'Inserts the current date after the cursor in ISO8086',
})

-- Use Enter and the backslash (the key above enter) to start a newline
-- below/above (respectivly) the current line.
vim.keymap.set('n', '<CR>', 'o<ESC>')
vim.keymap.set('n', '\\', 'O<ESC>')

-- Prefix k/j with the leader key to move the current line up/down.
vim.keymap.set('n', '<leader>k', function()
    for i = 1, math.max(vim.v.count, 1) do
        vim.fn.execute('m-2')
    end
end)
vim.keymap.set('n', '<leader>j', function()
    for i = 1, math.max(vim.v.count, 1) do
        vim.fn.execute('m+')
    end
end)

vim.api.nvim_create_user_command('Hebrew', 'set rightleft | set keymap=hebrew', {})
vim.api.nvim_create_user_command('English', 'set norightleft | set keymap=""', {})

-- Telescope bingings.
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Use :T for toggling Trouble.
vim.api.nvim_create_user_command('T', 'TroubleToggle', {})

-- Use :LR for LspRestart command.
vim.api.nvim_create_user_command('LR', 'LspRestart', {})
