local path_to_this = vim.env.myvimrc
local this_dir = vim.fs.dirname(path_to_this)
vim.opt.packpath:append { this_dir }

require('plugins')
require('options')
require('keymaps')
require('colorscheme')
require('statusline')
require('lean-files')
if vim.fn.executable('nu') == 1 then
    require('nu')
end

-- We need to remove this useless auto-generated file
data_path = vim.fn.stdpath('data')
filname_to_remove = data_path .. "\\shada\\main.shada.tmp.X"
if vim.fn.filereadable(filname_to_remove) == 1 then
    vim.fn.delete(filname_to_remove)
end

-- TODO:
-- - Look into :set exrc
