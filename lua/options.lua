vim.opt.nu = true
vim.opt.rnu = true

-- Tab settings.
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

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
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

vim.opt.shortmess:append("c")

-- Set the cmdline used by :grep.
vim.opt.grepprg = "rg --vimgrep"

-- TODO:
-- let g:copilot_assume_mapped = v:true

-- FINDING FILES
-- Search down into subdirectories.
vim.opt.path:append("*")
vim.opt.path:append("**")

-- NETRW SETTINGS
vim.g.netrw_banner = 0
-- vim.g.netrw_browse_split = 2
-- vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_preview = 1
-- netrw line numbers (https://www.reddit.com/r/neovim/comments/16r1rno/comment/kjffzbq/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"

-- STOCK COMPLETION SETTINGS
vim.opt.spell = true

-- Persistent undo.
vim.opt.undofile = true
