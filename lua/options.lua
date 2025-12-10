-- Line numbers and relative line numbers.
vim.opt.number = true
vim.opt.relativenumber = true

-- Tab and white-space settings.
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Keep 2 lines above and below the cursor at all times.
vim.opt.scrolloff = 2

-- Detect filetype.
vim.cmd("filetype on")
-- Add koka filetype.
vim.cmd("au BufRead,BufNewFile *.koka set filetype=koka | set syntax=ocaml")
vim.cmd("au BufRead,BufNewFile *.kk set filetype=koka | set syntax=ocaml")
-- Add yacc filetypes!
vim.cmd("au BufRead,BufNewFile *.ypp set filetype=yacc | set syntax=yacc")
-- Add prolog filetypes!
vim.cmd("au BufRead,BufNewFile *.pl  set filetype=prolog | set syntax=prolog")
-- Use autopep8 for python.
vim.cmd("au BufRead,BufNewFile *.py setlocal formatprg=autopep8\\ -")

-- Errors and things around the code.
vim.opt.signcolumn = 'yes'
-- Limiting the number of characters in a line.
vim.opt.colorcolumn = "81"
vim.opt.textwidth = 80

vim.opt.shortmess:append("c")

-- Set the cmdline used by :grep.
if vim.fn.executable("rg") then
    vim.opt.grepprg = "rg --vimgrep"
end

-- TODO:
-- let g:copilot_assume_mapped = v:true

-- FINDING FILES
-- Search down into subdirectories.
vim.opt.path:append("*")
vim.opt.path:append("**")

-- -- NETRW SETTINGS
-- vim.g.netrw_banner = 0
-- -- vim.g.netrw_browse_split = 2
-- -- vim.g.netrw_altv = 1
-- vim.g.netrw_liststyle = 3
-- vim.g.netrw_preview = 1
-- -- netrw line numbers (https://www.reddit.com/r/neovim/comments/16r1rno/comment/kjffzbq/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
-- vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"

-- STOCK COMPLETION SETTINGS
vim.opt.spell = true

-- Persistent undo.
vim.opt.undofile = true

-- Clipboard
vim.opt.clipboard:append 'unnamedplus'
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank {
        higroup = 'Highlight',
        timeout = 400,
        on_macro = true,
        on_visual = true,
    }
  end,
})

vim.g.have_nerd_font = true


vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.list = true
vim.opt.listchars = { tab = '> ', trail = '·' }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'split'
vim.opt.breakindent = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.winborder = 'rounded'

local opts = { noremap = true, silent = true }

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- set line wrap
vim.keymap.set('n', '<leader>lw', ':set wrap! <CR>', { desc = 'Toggle line wrap' })

-- Cycle through the buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)

-- Resize windows with <leader>w[/]
vim.keymap.set('n', '<leader>w[', function() vim.cmd('vertical resize -5') end, { desc = 'Shrink window width' })
vim.keymap.set('n', '<leader>w]', function() vim.cmd('vertical resize +5') end, { desc = 'Increase window width' })
