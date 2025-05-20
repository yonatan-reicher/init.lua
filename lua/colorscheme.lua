require("tokyonight").setup({
    style = "night",
    styles = {
      comments = {},
      keywords = { fg = "#569cd6" },
      functions = {},
      variables = {},
    },
    day_brightness = 0.25, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false, -- dims inactive windows

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    ---@param colors ColorScheme
    on_colors = function(colors) 
        if vim.o.background == "dark" then
            colors.bg = "#1e1e1e"
            colors.comment = "#6d7481"
            colors.green1 = "#4ec9b0"
        else
            colors.bg = "#ffffff"
            colors.green1 = "#4ec9b0"
        end
    end,
    
    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights Highlights
    ---@param colors ColorScheme
    on_highlights = function(highlights, colors) 
        -- highlights['@keyword'].fg = colors.blue2
        highlights['@keyword'] = { fg = colors.purple, italic = false }
        highlights['@property'] = '@variable'
        highlights['@variable.member'] = '@variable'
        highlights.Type.fg = colors.green1
        highlights.Constant.fg = colors.blue1
        highlights.TabLine.fg = colors.blue
        highlights.Conditional = '@keyword'
    end,

    -- All on_colors and on_highlights table keys and default values are here:
    -- https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_night.lua

    plugins = {
        all = true,
    },
})

vim.cmd [[colorscheme tokyonight]]
