-- This is a nicer comment string in my opinion.
vim.bo.commentstring = '-- %s'
-- Disable spell checking in Lean files, since it is not very useful.
-- Spell checking is a window-local option, we can't set it per-buffer,
-- so we just set it for the current window.
vim.wo.spell = false
vim.bo.tw = 100
vim.wo.colorcolumn = '101'
