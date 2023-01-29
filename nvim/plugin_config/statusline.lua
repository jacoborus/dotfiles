-- Set lualine as statusline
-- See `:help lualine.txt`

-- Copyright (c) 2023 jacoborus
-- MIT license, see LICENSE for more details.
local colors = {
  red1 = '#f43753',
  red2 = '#c5152f',
  red3 = '#79313c',
  blue1 = '#b3deef',
  blue2 = '#73cef4',
  blue3 = '#44778d',
  blue4 = '#335261',
  blue5 = '#293b44',
  green1 = '#c9d05c',
  green2 = '#9faa00',
  green3 = '#6a6b3f',
  green4 = '#464632',
  yellow1 = '#d3b987',
  yellow2 = '#ffc24b',
  yellow3 = '#715b2f',
  highlighted = '#ffffff',
  text = '#eeeeee',
  pearl = '#dadada',
  gandalf = '#bbbbbb',
  grey1 = '#999999',
  grey2 = '#666666',
  grey3 = '#444444',
  shadow = '#323232',
  bg = '#282828',
  dark = '#202020',
  darker = '#1d1d1d',
  darkest = '#000000',
}


local theme = {
  normal = {
    a = { fg = colors.grey3, bg = colors.blue1 },
    b = { fg = colors.shadow, bg = colors.blue2, gui = 'bold' },
    c = { fg = colors.blue1, bg = colors.blue4 },
    x = { fg = colors.blue1, bg = colors.blue4 },
    y = { fg = colors.shadow, bg = colors.blue2 },
    z = { fg = colors.grey3, bg = colors.blue1 },
  },
  insert = {
    a = { fg = colors.green4, bg = colors.green1 },
    b = { fg = colors.shadow, bg = colors.green2, gui = 'bold' },
    c = { fg = colors.green1, bg = colors.green4 },
    x = { fg = colors.green1, bg = colors.green4 },
    y = { fg = colors.shadow, bg = colors.green2 },
    z = { fg = colors.green4, bg = colors.green1 },
  },
  visual = {
    a = { fg = colors.yellow3, bg = colors.yellow1 },
    b = { fg = colors.shadow, bg = colors.yellow2, gui = 'bold' },
    c = { fg = colors.yellow1, bg = colors.yellow3 },
  },
  replace = {
    a = { fg = colors.red3, bg = colors.red1 },
    b = { fg = colors.shadow, bg = colors.red2, gui = 'bold' },
    c = { fg = colors.red1, bg = colors.red3 },
  },
  inactive = {
    a = { fg = colors.gandalf, bg = colors.grey2, gui = 'bold' },
    b = { fg = colors.gandalf, bg = colors.grey2 },
    c = { fg = colors.gandalf, bg = colors.grey3 },
  },
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = theme,
    component_separators = '|',
    section_separators = '',
    globalstatus = false,
  },
  extensions = {
    'nvim-tree',
    'fugitive',
    'fzf',
    'quickfix',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filename' },
    lualine_c = { 'branch', 'diff', 'diagnostics' },
    lualine_x = {
      'encoding',
      'fileformat',
      'filetype',
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'progress' },
    lualine_y = { 'location' },
    lualine_z = {}
  },

  -- winbar = {
  --   lualine_a = {
  --     function() return ' ' end,
  --   },
  --   lualine_b = {
  --     'filename',
  --   },
  --   lualine_c = { function() return ' ' end },
  --   lualine_x = {},
  --   lualine_y = {},
  --   lualine_z = {},
  -- },
  -- inactive_winbar = {
  --   lualine_a = { function() return ' ' end },
  --   lualine_b = { 'filename' },
  --   lualine_c = { function() return ' ' end },
  --   lualine_x = {},
  --   lualine_y = {},
  --   lualine_z = {}
  -- },

  -- tabline = {
  --   lualine_a = {},
  --   lualine_b = {},
  --   lualine_c = { 'filename' },
  --   lualine_x = {},
  --   lualine_y = {},
  --   lualine_z = { 'tabs' }
  -- },
}
