local G = vim.cmd.G
function keymap(shortcut, gitCommand)
    vim.keymap.set('n', shortcut, function () G(gitCommand) end)
end

-- keymap('gp', 'pull')
