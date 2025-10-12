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

vim.api.nvim_create_user_command('Hebrew', function()
    -- We could in theory keep spellchecking, and use a hebrew 'spelllang'
    -- setting, but I couldn't find one.
    -- TODO: Look at `:help hebrew.txt`
    -- set keymap=hebrew
    vim.cmd[[
        set rightleft
        set nospell
    ]]
end, {})
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
    if has_rnu_or_nu then resize_to = tonumber(resize_to) + 5 end
    vim.cmd ('vertical resize ' .. resize_to)
end, {})

vim.keymap.set('n', '>' , '>>')
vim.keymap.set('n', '<' , '<<')

-- Terminal mappings
vim.cmd [[autocmd TermOpen * startinsert]] -- Enter terminal mode automatically
vim.keymap.set('t', '<C-t>', '<C-\\><C-n>') -- Exit terminal mode with <C-t>
-- TODO: Move to another file
vim.cmd [[autocmd TermOpen * set nospell]] -- Disable spell checking in terminal buffers

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

-- Telescope bingings.
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>fj', builtin.jumplist, {})
vim.keymap.set('n', '<leader>fm', builtin.man_pages, {})
vim.keymap.set('n', '<leader>fc', builtin.commands, {})
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

-- Vim fugitive :tG should open in a new tab instead of a split.
vim.api.nvim_create_user_command('TG', function()
    vim.cmd('tab G')
end, {})


-- Why ride a bike when you can fly?
-- https://2.bp.blogspot.com/-d1GaUBk-Y10/TyFhskmCYRI/AAAAAAAAARQ/CIEx1V7FLqg/s640/vim-and-vigor-004-flying_is_faster_than_cycling.png
-- Honestly, <leader>fb (telescope buffer) is probably better, but this is so
-- cool.
vim.cmd[[
    nnoremap <leader>l :ls<CR>:b<space>
]]


function GoToNextBuffer()
end


-- Close the current buffer, but keep the window open.
vim.keymap.set('n', '<leader>d', function()
    -- Get the current buffer, and start going back through the jump list until
    -- we reach a buffer that is not the current one. If we don't, we just go to
    -- the next buffer
    local buffer_number = vim.fn.bufnr("%")
    local i = vim.fn.getjumplist()[2]
    while i > 0 and vim.fn.bufnr('%') == buffer_number do
        vim.cmd[[exe "normal \<c-o>"]]
        i = i - 1
    end
    local found = i > 0
    if not found then
        vim.cmd.bnext()
    end
    vim.cmd.bdelete(buffer_number)
end)

-- Close the current buffer, and go to the next one.
vim.keymap.set('n', '<leader>bd', function()
    local buffer_number = vim.fn.bufnr("%")
    vim.cmd.bnext()
    vim.cmd.bdelete(buffer_number)
end)
    -- local buffer_info = vim.fn.getbufinfo("%")[1]
    -- assert(buffer_info.bufnr == buffer_number , "Buffer number mismatch! This should not happen.")
    -- local is_buffer_in_multiple_windows = #buffer_info.windows > 1
    -- if is_buffer_in_multiple_windows then
    --     -- Just close the window, don't delete the buffer
    --     vim.cmd.close()
    -- else
    --     -- The buffer should be closed!
    --     vim.cmd.bnext()
    --     vim.cmd.bdelete(buffer_number) -- could also do `:bd #` to delete the last buffer
    -- end

-- Close all other buffers
vim.api.nvim_create_user_command('CloseOtherBuffers', function()
    local current_buffer = vim.fn.bufnr('%')
    local buffers = vim.fn.getbufinfo({ buflisted = 1 })
    for _, buf in ipairs(buffers) do
        if buf.bufnr ~= current_buffer then
            vim.cmd('bdelete! ' .. buf.bufnr)
        end
    end
end, {})

-- Close all buffers that are not open in any window
vim.api.nvim_create_user_command('CloseUnusedBuffers', function()
    local buffers = vim.fn.getbufinfo({ buflisted = 1 })
    for _, buf in ipairs(buffers) do
        if #buf.windows == 0 then
            vim.cmd.bdelete(buf.bufnr)
        end
    end
end, {})

vim.keymap.set('n', 'gD', function()
    vim.cmd[[ tab split | norm gd ]]
end)
