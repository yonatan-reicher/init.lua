require 'helpers'

-- Delay setting options. Not sure, but might be because the markdown plugin is
-- setting options too, and loads right after.
vim.schedule(function()
    setTabStop2()
end)
