require 'helpers'

function confirmMarkdownFileType()
    return vim.bo.ft == 'markdown'
end

-- Delay setting options. Not sure, but might be because the markdown plugin is
-- setting options too, and loads right after.
vim.schedule(function()
    -- Sometimes this sets for the wrong buffer. Make sure it doesn't.
    if not confirmMarkdownFileType() then return end
    setTabStop2()
end)
