util = require("tokyonight.util")
require("tokyonight").setup({
    style = "night",
    styles = {
      comments = {},
      keywords = { fg = "#569cd6" },
      functions = {},
      variables = {},
    },
    day_brightness = 0.25, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = true,
    dim_inactive = true, -- dims inactive windows
    terminal_colors = true, -- whether to set the terminal colors (e.g. `:terminal`, `:!`, etc.)

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    ---@param colors ColorScheme
    on_colors = function(colors) 
        if vim.o.background == "dark" then
            colors.gray = "#2d2d30"
            colors.bg = "#1c1c1c"
            colors.bg_dark = util.blend(colors.bg, 0.35, colors.black)
            colors.comment = "#6d7481"
            colors.green1 = "#4ec9b0"
        else
            colors.gray = "#dddded"
            colors.bg = "#fdfdfd"
            colors.fg = "#101030"
            colors.green1 = "#43b07d"
            colors.bg_dark = util.blend(colors.bg, 0.5, colors.gray)
        end
        colors.dark_gray = util.blend(colors.gray, 0.5, colors.black)
        colors.cyan = "#9cdcfe"
        colors.soft_yellow = "#dcdcaa"
        if vim.o.background == "light" then
            colors.soft_yellow = util.darken(colors.soft_yellow, 18.8)
            colors.soft_yellow = util.blend(colors.soft_yellow, 0.5, colors.yellow)
        end
    end,
    
    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights Highlights
    ---@param colors ColorScheme
    on_highlights = function(highlights, colors) 
        -- highlights['@keyword'].fg = colors.blue2
        -- print(vim.inspect(colors))
        highlights['@keyword'] = { fg = colors.purple, italic = false }
        highlights['@keyword.import'] = '@keyword'
        highlights['@property'] = '@variable'
        highlights['@variable.member'] = '@variable'
        highlights['@variable.builtin'] = 'Special'
        highlights.Function.fg = colors.soft_yellow
        highlights.Type.fg = colors.green1
        highlights.Constant.fg = colors.blue1
        highlights.TabLine.fg = colors.blue
        highlights.Conditional = '@keyword'
        highlights.ColorColumn.bg = colors.bg_dark1
        highlights.Directory.fg = colors.blue1
        highlights.WinSeparator.fg = colors.blue
        highlights.SignColumn.bg = nil
        highlights.LineNr.fg = highlights.CursorLineNr.fg
        highlights.MatchParen.bg = colors.black
        highlights.MatchParen.italic = true
        highlights.StatusLine.bg = colors.gray
        highlights.StatusLineNC.bg = colors.dark_gray
        highlights['@comment.todo'] = highlights.Todo
        highlights.Special.fg = nil
        highlights.Pmenu = colors.white
        highlights.NormalFloat = { link = 'Pmenu' }
        highlights.FloatShadow = { bg = colors.black, blend = 50 }
        -- Markdown
        -- Markdown already looks like what it renders to, so we want as little
        -- colors as possible while providing useful text decoration.
        highlights['@markup.heading.1.markdown'] = { bold = true }
        highlights['@markup.heading.2.markdown'] = { bold = true }
        highlights['@markup.heading.3.markdown'] = { bold = true }
        highlights['@markup.heading.4.markdown'] = { bold = true }
        highlights['@markup.heading.5.markdown'] = { bold = true }
        highlights['@markup.heading.6.markdown'] = { bold = true }
        highlights['@markup.raw.markdown_inline'] = { bg = colors.dark_gray }
        highlights['@markup.list.markdown'] = {}
        -- for key, value in pairs(highlights) do
        --     if key:lower():find('float') or key:lower():find('shadow') then
        --         print(key , ' = ' , vim.inspect(value))
        --     end
        -- end
    end,

    -- All on_colors and on_highlights table keys and default values are here:
    -- https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_night.lua

    plugins = {
        all = true,
    },
})

vim.cmd [[colorscheme tokyonight]]
