vim.opt.nu = true
vim.opt.rnu = true

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
vim.opt.grepprg = "rg --vimgrep"

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



-- These are settings I am interested in checking out
--[==[
vim.cmd[[colorscheme habamax]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.opt.list = true
vim.opt.listchars = { tab = '> ', trail = '·' }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'split'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.winborder = 'rounded'
vim.opt.winborder = 'shadow'
vim.opt.clipboard:append('unnamedplus')
vim.colorcolumn = 80
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>', { desc = "Exit terminal on window operations" })

-- Tab options
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4


-- Lsp
vim.lsp.config['rust-analyzer'] = {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { { 'Cargo.toml', 'Cargo.lock' }, '.git' }
}
vim.lsp.enable('rust-analyzer')

--]==]


--[==[
-- Some more things I took from somewhere, should consider what is interesting
-- here
-- Custom Options
vim.o.clipboard = 'unnamedplus'

local opts = { noremap = true, silent = true }

-- Remap esc to jk so that you can exit insert mode by jk fast sequence
vim.keymap.set('i', 'jk', '<Esc>', opts)

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- set line wrap
vim.keymap.set('n', '<leader>lw', ':set wrap! <CR>', { desc = 'Toggle line wrap' })

-- Save files
vim.keymap.set('n', '<leader>ff', ':wall <CR>', opts)

-- Buffers
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { desc = 'Delete the current buffer.' })
vim.keymap.set('n', '<leader>bda', ':%bd|edit#|bd#<CR>', {desc = "Delete all buffers except the current buffer."})

-- Cycle through the buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)

-- Setup for tabs spacing
vim.opt.tabstop = 3 -- Number of spaces a <Tab> counts for
vim.opt.shiftwidth = 3 -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.softtabstop = 3 -- Number of spaces for <Tab> in insert mode

-- Resize windows with <leader>w[
vim.keymap.set('n', '<leader>w[', function() vim.cmd('vertical resize -5') end, { desc = 'Shrink window width' })

-- Resize windows with <leader>w]
vim.keymap.set('n', '<leader>w]', function() vim.cmd('vertical resize +5') end, { desc = 'Increase window width' })

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Toggle autosave. You have to install this plugin as I described above.
vim.keymap.set('n', '<leader>ts', ':ASToggle<CR>', { desc = 'Toggle auto save' })

-- Show relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Open file tree. See the file tree section to enable this plugin 
vim.keymap.set('n', '<leader>ft', ':Neotree current <CR>', { desc = 'Open file tree' })

-- Split window
vim.keymap.set('n', '<leader>wv', '<C-w>v', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>wcs', '<C-w>s', { desc = 'Split window horizontally' })

-- Navigate between windows here <CR> simulates the enter press
vim.keymap.set('n', '<leader>wh', ':wincmd h<CR>', { desc = 'Navigate to left split' })
vim.keymap.set('n', '<leader>wl', ':wincmd l<CR>', { desc = 'Navigate to right split' })
vim.keymap.set('n', '<leader>wk', ':wincmd k<CR>', { desc = 'Navigate to upper split' })
vim.keymap.set('n', '<leader>wj', ':wincmd j<CR>', { desc = 'Navigate to lower split' })


--]==]
