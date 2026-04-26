-- The main leader key will be space.
vim.g.mapleader = ' '

-- Or <C-\>date!
vim.keymap.set('i', '<C-\\>date', "<C-R>=strftime('%Y-%m-%d')<CR>")
-- And <C-\>time for the current time.
vim.keymap.set('i', '<C-\\>time', "<C-R>=strftime('%H:%M')<CR>")
vim.keymap.set('i', '<C-\\>day', "<C-R>=strftime('%A')<CR>")
vim.keymap.set('i', '<C-\\>month', "<C-R>=strftime('%B')<CR>")

-- Use Enter and the backslash (the key above enter) to start a newline
-- below/above (respectivly) the current line.
vim.keymap.set('n', '<CR>', 'o<ESC>')
vim.keymap.set('n', '\\', 'O<ESC>')
-- I run this all the time...
vim.keymap.set('n', '<leader>w', ':w | noh<CR>')
vim.keymap.set('n', '<leader>bg', function()
    -- Called 'bg' because I used to use `:set bg=`.
    local current = vim.o.background
    if current == 'dark' then
        vim.o.background = 'light'
    else
        vim.o.background = 'dark'
    end
end, { desc = 'Toggle the current background color' })

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

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- set line wrap
vim.keymap.set('n', '<leader>lw', ':set wrap! <CR>', { desc = 'Toggle line wrap' })

vim.keymap.set('n', '<Tab>', ':tabnext<CR>')
vim.keymap.set('n', '<S-Tab>', ':tabprev<CR>')
-- Setting the tab behaviour above seems to break `<C-i>`, as it seems to be
-- just a recursive mapping for `<Tab>` (which does the same).
vim.keymap.set('n', '<C-i>', '<C-i>')
-- Also have [j and ]j for consistency!
vim.keymap.set('n', '[j', '<C-o>')
vim.keymap.set('n', ']j', '<C-i>')

vim.keymap.set('n', '<C-w>[', function() vim.cmd('vertical resize -5') end, { desc = 'Shrink window width' })
vim.keymap.set('n', '<C-w>]', function() vim.cmd('vertical resize +5') end, { desc = 'Increase window width' })

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

vim.api.nvim_create_user_command('Term', function()
    vim.cmd[[
        tabnew
        TabooRename term
        terminal
    ]]
end, {})

vim.keymap.set('n', '<leader>t', '<Cmd>:Term<CR>', {
    desc = 'Synonym for :Term',
})

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
if moduleExists 'telescope.builtin' then
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
end

-- Digraphs
vim.keymap.set('i', '<C-\\>', '<C-k>')
-- Digraphs are added via their UTF-16 code point.
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
vim.cmd.digraphs('JO', 0x2A1D) -- ⨝
vim.cmd.digraphs('ns', 0x2099) -- ₙ
vim.cmd.digraphs('ms', 0x2098) -- ₘ
vim.cmd.digraphs('|-', 0x22A2) -- ⊢
vim.cmd.digraphs('-|', 0x22A3) -- ⊣
vim.cmd.digraphs('TT', 0x22A4) -- ⊤
vim.cmd.digraphs('-T', 0x22A5) -- ⊥

-- Vim fugitive :TG should open in a new tab instead of a split.
vim.api.nvim_create_user_command('TG', function()
    vim.cmd[[
        tab G
        TabooRename git
    ]]
end, {})

vim.keymap.set('n', '<leader>g', '<cmd>TG<CR>', {
    desc = 'Synonym for :TG',
})


-- vim.keymap.set('n', '<leader>c', function()
--     vim.cmd 'G commit'
--     vim.cmd.norm 'Gk$yiWgg'
--     vim.cmd.norm 'aupdate '
--     vim.cmd.norm 'p$'
-- end)


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

local function get_text(pos1, pos2)
    local n_lines = math.abs(pos2[2] - pos1[2]) + 1
    local lines = vim.api.nvim_buf_get_lines(0, pos1[2] - 1, pos2[2], false)
    lines[1] = string.sub(lines[1], pos1[3], -1)
    if n_lines == 1 then
        lines[n_lines] = string.sub(lines[n_lines], 1, pos2[3] - pos1[3] + 1)
    else
        lines[n_lines] = string.sub(lines[n_lines], 1, pos2[3])
    end
    return table.concat(lines, '\n')
end


vim.api.nvim_create_user_command('Cap', function()
    local pos1 = vim.fn.getpos("'<")
    local pos2 = vim.fn.getpos("'>")

    local sel = get_text(pos1, pos2)
    vim.cmd.norm(#sel .. 'x')
    -- TODO
    -- vim.cmd.

    vim.fn.setpos("'<", s_start)
    vim.fn.setpos("'>", s_end)
end, {})

-- Format the current buffer.
vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, {
    desc = 'Format the current buffer',
})
vim.diagnostic.config {
    -- virtual_lines = {
    --     current_line = true,
    -- },
    jump = {
        on_jump = function(diagnostic, buf)
            if not diagnostic then return end

            vim.diagnostic.show(
              diagnostic.namespace,
              buf,
              { diagnostic },
              { virtual_lines = { current_line = true }, virtual_text = false }
            )
        end,
        -- float = true,
    },
}

-- Use [n and ]n to go to the first and the last search result
vim.keymap.set('n', '[n', 'ggn')
vim.keymap.set('n', ']n', 'GN')

-- Use :DiffOrig to see the difference from the unmodified file for the current
-- buffer.
vim.api.nvim_create_user_command(
    'DiffOrig',
    'vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis',
    { desc = 'Show difference on a modified file' }
)

-- Just like `grr` and `gri`
vim.keymap.set('n', 'grt', vim.lsp.buf.type_definition, {
    desc = 'Go to type-definition of symbol'
})

vim.api.nvim_create_user_command(
    'Banner',
    function(opts)
        local title = opts.args
        local commentstring = vim.o.commentstring
        local textwidth = vim.o.textwidth
        local left, right = string.match(commentstring, '^(.*)%%s(.*)$')
        vim.validate { title = { title, 'string' } }
        local line_width = textwidth - #left - #right
        -- Make a banner consisting of a border at the top and bottom, and a
        -- title in the middle
        local border_line = string.rep('=', line_width)
        -- For the title line, we have two cases:
        -- 1. The comment string ends with '%s'. This means that nothing is
        -- needed to close a comment. In this case, we want nothing on the
        -- right.
        -- 2. The comment string does not end after '%s' (e.g. it is '/* %s */').
        -- In this case, we want to add spaces before the closing part of the
        -- comment.
        local title_left_padding = math.floor((line_width - #title) / 2)
        local title_right_padding = line_width - title_left_padding - #title
        if #right == 0 then title_right_padding = 0 end
        local title_line = string.rep(' ', title_left_padding) .. title .. string.rep(' ', title_right_padding)
        local lines = {border_line, title_line, border_line}
        -- Modify the lines to be comments.
        for i, line in ipairs(lines) do
            lines[i] = string.gsub(commentstring, '%%s', line)
        end
        vim.api.nvim_put( -- Add text at cursor
            lines, -- input
            'l', -- char-wise mode
            true, -- after cursor
            true -- put cursor after the inserted text
        )
    end, {
    desc = 'Insert a banner for separating source-code files to pretty sections',
    nargs = 1,
})
