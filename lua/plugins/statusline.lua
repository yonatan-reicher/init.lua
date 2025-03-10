local gl = require('galaxyline')
local gl_theme = require('galaxyline.theme')
local gl_vcs = require('galaxyline.provider_vcs')
local gl_condition = require('galaxyline.condition')
local navic = require('nvim-navic')

local gls = gl.section
gl.short_line_list = {'LuaTree','vista','dbui'}

local colors = {
  bg = '#282c34',
  yellow = '#fabd2f',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#afd700',
  orange = '#FF8800',
  purple = '#5d4d7a',
  magenta = '#d16d9e',
  grey = '#c0c0c0',
  blue = '#0087d7',
  red = '#ec5f67'
}

gls.left[1] = {
  ViMode = {
    provider = function()
      local alias = {
          n = 'NOR',
          i = 'INS',
          c = 'CMD',
          v = 'VIS',
          V = 'VIS',
          t = 'TER',
          [''] = 'VIS',
          [''] = 'VIS'
      }
      return alias[vim.fn.mode()]
    end,
    separator = '',
    separator_highlight = {colors.purple,function()
      if not gl_condition.buffer_not_empty() then
        return colors.purple
      end
      return colors.darkblue
    end},
    highlight = {colors.darkblue,colors.purple,'bold'},
  },
}
gls.left[2] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = gl_condition.buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.darkblue},
  },
}
gls.left[3] = {
  FileName = {
    provider = 'FileName',
    condition = gl_condition.buffer_not_empty,
    highlight = {colors.magenta,colors.darkblue},
  }
}
gls.left[4] = {
  Navic = {
    provider = function() return '> ' .. navic.get_location() end,
    condition = function() return navic.is_available() end,
    highlight = {nil,colors.darkblue},
    separator = '',
    separator_highlight = {colors.purple,colors.darkblue},
  }
}

gls.left[5] = {
  GitIcon = {
    provider = function() return '  ' end,
    condition = gl_condition.buffer_not_empty,
    highlight = {colors.orange,colors.purple},
  }
}
gls.left[6] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = gl_condition.buffer_not_empty,
    highlight = {colors.orange,colors.purple},
    separator = '█',
    separator_highlight = {colors.purple,colors.purple},
  }
}

local checkwidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

gls.left[7] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = checkwidth,
    icon = ' ',
    highlight = {colors.green,colors.purple},
  }
}
gls.left[8] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = checkwidth,
    icon = '  ',
    highlight = {colors.orange,colors.purple},
  }
}
gls.left[9] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = checkwidth,
    icon = '  ',
    highlight = {colors.red,colors.purple},
  }
}
gls.left[10] = {
  LeftEnd = {
    provider = function() return '' end,
    separator = '',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.purple,colors.purple}
  }
}
gls.left[11] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red,colors.bg}
  }
}
gls.left[12] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.blue,colors.bg},
  }
}

gls.right[1] = {
  FileSize = {
    provider = 'FileSize',
    highlight = {colors.grey,colors.purple},
    separator = '',
    separator_highlight = {colors.purple,colors.bg},
  }
}
gls.right[2] = {
  FileFormat = {
    provider = 'FileFormat',
    highlight = {colors.grey,colors.purple},
  }
}
gls.right[3] = {
  Space = {
    provider = function() return ' ' end,
    highlight = {colors.grey,colors.purple},
  },
}
gls.right[4] = {
  FileEncode = {
    provider = 'FileEncode',
    highlight = {colors.grey,colors.purple},
  }
}
gls.right[5] = {
  LineInfo = {
    provider = 'LineColumn',
    highlight = {colors.grey,colors.purple},
    separator = '|',
    separator_highlight = {colors.bg,colors.purple},
  },
}
gls.right[6] = {
  PerCent = {
    provider = 'LinePercent',
    highlight = {colors.grey,colors.purple},
  }
}
gls.right[6] = {
  ScrollBar = {
    provider = 'ScrollBar',
    highlight = {colors.yellow,colors.purple},
  }
}

gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = '',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.grey,colors.purple}
  }
}


gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'FileSize',
    separator = '',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.grey,colors.purple}
  }
}

