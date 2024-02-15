local custom = {}

custom["00sapo/visual.nvim"] = {
  opts = { treesitter_textobjects = true },
  event = "VeryLazy",
  config = function()
    require('visual').setup()
    vim.cmd("VisualEnable")
  end
}

custom["folke/flash.nvim"] = {
  lazy = true,
  event = "VeryLazy",
  opts = {
    modes = {
      char = {
        jump_labels = true
      }
    }
  },
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}

return custom
