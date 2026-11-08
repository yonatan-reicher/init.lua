-- Default: vim.o.statusline = "%<%f %h%m%r%=%-14.(%l,%c%V%) %P"
local navic = moduleExists 'nvim-navic' and require 'nvim-navic'

function get_location()
    if not navic then return '' end
    local location = navic.get_location()
    if location == '' then return '' end
    return navic.get_location()
end

-- Reminders:
-- %t - file name (tail)
-- %M - modified
-- %R - readonly
-- %Y - file type
-- %<N>* - highlight group User<N>
-- %{..} - evaluate vimscript
-- %w - preview
hls = { 'StatusLineFileName', 'StatusLineLookingAt' }
for i, hl in ipairs(hls) do
    vim.api.nvim_set_hl(0, 'User' .. i, vim.api.nvim_get_hl(0, { name = hl }))
end
local left = "%1*%t [%M%R%Y] %2*%{v:lua.get_location()}%* %w"
local right = "%{&fileencoding} %{&fileformat} %4.l,%-3.(%c%V%) %P%<"
vim.o.statusline = left .. "%=" .. right
