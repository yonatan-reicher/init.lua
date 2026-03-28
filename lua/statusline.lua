-- Default: vim.o.statusline = "%<%f %h%m%r%=%-14.(%l,%c%V%) %P"
local navic = moduleExists 'nvim-navic' and require 'nvim-navic'

function get_location()
    return navic and navic.get_location() or ''
end

local left = "%<%t%m %{v:lua.get_location()} %w"
local right = "%{&fileencoding} %{&fileformat} %4.l,%-3.(%c%V%) %P"
vim.o.statusline = left .. "%=" .. right
