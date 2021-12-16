-- ubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.
-- Modified by j4ger (adjusted for lunarvim)

local lualine = lvim.builtin.lualine

-- Reset lvim's default sections
lualine.sections = {
    lualine_a = {}, lualine_b = {}, lualine_c = {},
    lualine_x = {}, lualine_y = {}, lualine_z = {}
}

lualine.inactive_sections = {
    lualine_a = {}, lualine_b = {}, lualine_c = {},
    lualine_x = {}, lualine_y = {}, lualine_z = {}
}

-- stylua: ignore
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = colors.black },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

local options = lualine.options
options.theme = bubbles_theme
options.component_separators = '|'
options.section_separators = { left = '', right = '' }

local sections = lualine.sections
sections.lualine_a = {
  { 'mode', separator = { left = '' }, right_padding = 2 },
}
sections.lualine_b = { 'filename', 'branch' }
sections.lualine_c = { 'fileformat' }
sections.lualine_x = {}
sections.lualine_y = { 'filetype', 'progress' }
sections.lualine_z = {
  { 'location', separator = { right = '' }, left_padding = 2 },
}

local inactive_sections = lualine.inactive_sections
inactive_sections.lualine_a = { 'filename' }
inactive_sections.lualine_b = {}
inactive_sections.lualine_c = {}
inactive_sections.lualine_x = {}
inactive_sections.lualine_y = {}
inactive_sections.lualine_z = { 'location' }

lualine.tabline = {}
lualine.extensions = {}

