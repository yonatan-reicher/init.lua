-- In this file, we redefine the 'K' key-map to follow wiki-links and markdown
-- links. These are '[[link]]' and '[text](link)' respectively. We refer to both
-- of these as links.

-- Gets the text inside the cursor's markdown link, if we are inside one.
function findMarkdownLink(line, column)
    -- Declare variables
    local link_start = nil
    local link_end = nil
    local text_start = nil
    local text_end = nil
    -- Move left.
    -- A state machine! Must first look for link start, then text end, then
    -- text start.
    local left = column
    local state = 0
    print('start')
    while true do
        if left < 1 then return nil end
        if line:sub(left, left) == '(' then
            print('a')
            if state ~= 0 then return nil end
            link_start = left + 1
            state = 1
        elseif line:sub(left, left) == ']' then
            print('b')
            if state ~= 1 then return nil end
            if line:sub(left + 1, left + 1) ~= '(' then return nil end
            text_end = left - 1
            state = 2
        elseif line:sub(left, left) == '[' then
            print('c')
            if state ~= 2 then return nil end
            text_start = left + 1
            state = 3
            break
        elseif line:sub(left, left) == ')' then
            if left ~= column then
                return nil
            end
        end
        left = left - 1
    end
    -- Move right.
    print('d')
    local right = math.max(column, link_start)
    while true do
        if right > #line then return nil end
        if line:sub(right, right) == ')' then
            link_end = right - 1
            break
        end
        if line:sub(right, right) == '(' then return nil end
        right = right + 1
    end
    return line:sub(link_start, link_end)
end

-- Gets the text inside the cursor's wiki-link, if we are inside one.
function findWikiLink(line, column)
    -- TODO
end

function followLink()
    local cursor = vim.api.nvim_win_get_cursor(0)
    -- Yank the link under the cursor.
    -- Start by trying a markdown link, otherwise, use this smelly wiki-link code.
    local line = vim.api.nvim_get_current_line()
    local markdown_link_text = findMarkdownLink(line, cursor[2])
    local link = nil
    if markdown_link_text ~= nil then
        link = markdown_link_text
    else
        vim.cmd[[norm vi[y]]
        link = vim.fn.getreg('\"')
    end
    local dir = vim.fn.expand('%:p:h')
    local potential_paths = {
        dir .. '/' .. link,
        dir .. '/' .. link .. '.md',
        link,
        link .. '.md',
    }
    local path = ''
    for _, p in ipairs(potential_paths) do
        if vim.fn.filereadable(p) == 1 then
            path = p
            break
        end
    end
    if path == '' then
        print('No file found for link: ' .. link)
        return
    end
    vim.cmd.edit(path)
end


vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function(args)
        vim.schedule(function()
            vim.keymap.set('n', 'K', followLink, {
                buffer = args.buf,
                desc = 'Follow wiki-link link under cursor',
            })
        end)
    end,
})
