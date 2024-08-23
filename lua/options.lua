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

-- Errors and things around the code.
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

vim.opt.shortmess:append("c")

-- TODO:
-- let g:copilot_assume_mapped = v:true
