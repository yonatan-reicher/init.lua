function followWikiLink()
    vim.cmd[[norm vi[y]]  -- Yank the wiki-link under the cursor
    local wiki_link = vim.fn.getreg('\"')
    local dir = vim.fn.expand('%:p:h')
    local potential_paths = {
        dir .. '/' .. wiki_link,
        dir .. '/' .. wiki_link .. '.md',
    }
    local path = ''
    for _, p in ipairs(potential_paths) do
        if vim.fn.filereadable(p) == 1 then
            path = p
            break
        end
    end
    if path == '' then
        print('No file found for wiki-link: ' .. wiki_link)
        return
    end
    vim.cmd.edit(path)
end


vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function(args)
        vim.schedule(function()
            vim.keymap.set('n', 'K', followWikiLink, {
                buffer = args.buf,
                desc = 'Follow wiki-link link under cursor',
            })
        end)
    end,
})
