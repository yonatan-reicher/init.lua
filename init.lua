local path_to_this = vim.env.myvimrc
local this_dir = vim.fs.dirname(path_to_this)
-- This tells Neovim to load plugins and packages from this directory
vim.opt.packpath:append { this_dir }

require 'helpers'
require('options')
require('keymaps')
require('plugins')
require 'language-servers'
require('colorscheme')
require('statusline')
require('lean-files')
require('rust')
require('project-local-configuration')
require('obsidian')
require 'latex'
if vim.fn.executable('nu') == 1 then
    require('nu')
end
