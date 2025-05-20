-- The main leader key will be space.
vim.g.mapleader = ' '

-- Or <C-\>date!
vim.keymap.set('i', '<C-\\>date', "<C-R>=strftime('%Y-%m-%d')<CR>")
-- And <C-\>time for the current time.
vim.keymap.set('i', '<C-\\>time', "<C-R>=strftime('%H:%M')<CR>")

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

-- Use :T for toggling Trouble.
vim.api.nvim_create_user_command('T', 'TroubleToggle', {})

-- Use :LR for LspRestart command.
vim.api.nvim_create_user_command('LR', 'LspRestart', {})

-- Use :Size to set the window size to be up to the color column.
vim.api.nvim_create_user_command('Size', function()
    local has_rnu_or_nu = vim.o.rnu or vim.o.nu
    local color_column = vim.o.colorcolumn
    local resize_to = color_column
    if has_rnu_or_nu then resize_to = resize_to + 5 end
    vim.cmd ('vertical resize ' .. resize_to)
end, {})

vim.keymap.set('n', '>' , '>>')
vim.keymap.set('n', '<' , '<<')

-- Terminal mappings
vim.cmd [[autocmd TermOpen * startinsert]] -- Enter terminal mode automatically
vim.keymap.set('t', '<C-t>', '<C-\\><C-n>') -- Exit terminal mode with <C-t>
-- vim.opt.shell = 'nu'
-- vim.opt.shellpipe = 'out+err>'
-- vim.opt.shellslash = true
-- vim.opt.shellredir = 'out+err>%s'
-- vim.opt.shellcmdflag = '-c'
-- vim.opt.shellquote = ''
-- vim.opt.shellxquote = ''
vim.api.nvim_create_user_command('Terminal', 'terminal nu', {})
vim.api.nvim_create_user_command('TabTerminal', 'tabnew | Terminal', {})

-- :Config commands
function ConfigInit(a)
    vim.cmd('e $MYVIMRC')
end
function Config(a)
    if not(a.args == '') then
        init_file_path = vim.fn.expand('$MYVIMRC')
        config_dir_path = vim.fs.dirname(init_file_path)
        filename = config_dir_path .. '/lua/' .. a.args .. '.lua'
        if vim.fn.filereadable(filename) == 1 then
            vim.cmd('e ' .. filename)
        else
            print('Config file not found: ' .. filename)
        end
    else
        vim.cmd('e $MYVIMRC')
        vim.cmd('Explore')
    end
end
vim.api.nvim_create_user_command('ConfigInit', ConfigInit, { nargs = '?' })
vim.api.nvim_create_user_command('Config', Config, { nargs = '?' })
-- TODO: Why doesnt this work?
vim.api.nvim_create_user_command('TabConfigInit', 'tabnew | ConfigInit', { nargs = '?' })
vim.api.nvim_create_user_command('TabConfig', 'tabnew | Config', { nargs = '?' })

-- Telescope bingings.
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>fF', ':Telescope<CR>', {})

-- Digraphs
vim.keymap.set('i', '<C-\\>', '<C-k>')
vim.cmd.digraphs('-m', 0x21A4) -- ↤
vim.cmd.digraphs('m^', 0x21A5) -- ↥
vim.cmd.digraphs('m-', 0x21A6) -- ↦
vim.cmd.digraphs('mv', 0x21A7) -- ↧
vim.cmd.digraphs('-M', 0x27FB) -- ⟻
vim.cmd.digraphs('M-', 0x27FC) -- ⟼
vim.cmd.digraphs('=m', 0x2906) -- ⤆
vim.cmd.digraphs('m=', 0x2907) -- ⤇
vim.cmd.digraphs('=M', 0x27FD) -- ⟽
vim.cmd.digraphs('M=', 0x27FE) -- ⟾
vim.cmd.digraphs('in', 0x2208) -- ∈
vim.cmd.digraphs('nn', 0x2209) -- ∉
