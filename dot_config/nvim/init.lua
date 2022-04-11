-- neovide config
vim.o.guifont = "FiraCode Nerd Font Mono:h10"
vim.g.neovide_refresh_rate = 240
vim.g.neovide_transparency = 0.75
vim.g.neovide_cursor_vfx_mode = "pixiedust"

-- plugins
require('jetpack').setup({
  'kyazdani42/nvim-web-devicons',
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
  { 'ms-jpq/chadtree', branch = 'chad', run = ':CHADdeps'},
  'folke/which-key.nvim',
  'itchyny/lightline.vim',
  'alvarosevilla95/luatab.nvim',
  'arcticicestudio/nord-vim',
  'sunjon/shade.nvim',
  'akinsho/toggleterm.nvim',
})
require('jetpack').optimization = 1

-- terminal configs (with lazygit integration)
local Terminal  = require('toggleterm.terminal').Terminal

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("Closing terminal")
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

-- keybindings
vim.g.mapleader = " "

local whichkey = require('which-key')

whichkey.register({
  f = {
    name = "file tree",
    o = {"<cmd>CHADopen<cr>", "show file tree"}
  },
  t = {
    name = "terminal",
    o = {"<cmd>ToggleTerm direction=tab<cr>", "open terminal as separate tab"},
    v = {"<cmd>ToggleTerm direction=vertical<cr>", "open terminal vertically"},
    w = {"<cmd>ToggleTerm direction=horizontal<cr>", "open terminal horizontally"},
  },
  g = {
    name = "git",
    l = {"<cmd>lua _lazygit_toggle()<cr>", "open lazygit"}
  }
},
{ prefix = "<leader>"}
)

whichkey.register({
  ["<c-s>"] = { "<cmd>w<cr>", "save file" }
})

-- color scheme
vim.cmd('colorscheme nord')


