-- Please check `lua/core/settings.lua` to view the full list of configurable settings
local settings = {}

-- Examples
settings["use_ssh"] = false

settings["use_copilot"] = false

settings["transparent_background"] = true

settings["external_browser"] = "xdg-open"

settings["colorscheme"] = "tokyonight-moon"

settings["disabled_plugins"] = {
  "rhysd/clever-f.vim",
  "phaazon/hop.nvim",
  "mfussenegger/nvim-treehopper",
  "karb94/neoscroll.nvim"
}

settings["lsp_deps"] = function(defaults)
  return {
	"bashls",
	-- "clangd",
	"html",
	"jsonls",
	"lua_ls",
	"taplo",
	-- "pylsp",
	-- "gopls",
  }
  end

settings["null_ls_deps"] = function(defaults)
  return {
	-- "clang_format",
	-- "gofumpt",
	-- "goimports",
	-- "prettier",
	"shfmt",
	"stylua",
	-- "vint",
  }
  end

settings["dap_deps"] = function(defaults)
  return {
	"codelldb", -- C-Family
	-- "delve", -- Go
	-- "python", -- Python (debugpy)
  }
  end

settings["treesitter_deps"] = function(defaults)
  return {
	"bash",
	"c",
	"cpp",
	"css",
	"go",
	"gomod",
	"html",
	"javascript",
	"json",
	"latex",
	"lua",
	"make",
	"markdown",
	"markdown_inline",
	"python",
	"rust",
	"typescript",
	"vimdoc",
	"vue",
	"yaml",
	"toml",
	"verilog",
	"dart"
  }
  end

settings["gui_config"] = function(defaults)
  return {
	font_name = "Monospace",
	font_size = 16,
  }
  end

settings["neovide_config"] = function(defaults)
  return {
	no_idle = true,
	-- refresh_rate = 165,
	cursor_vfx_mode = "railgun",
	cursor_vfx_opacity = 200.0,
	cursor_antialiasing = true,
	cursor_trail_length = 0.05,
	cursor_animation_length = 0.03,
	cursor_vfx_particle_speed = 20.0,
	cursor_vfx_particle_density = 5.0,
	cursor_vfx_particle_lifetime = 1.2,
  }
  end

settings["dashboard_image"] = function(defaults)
  return {
[[                                                 .]],
[[                       ..                     ..  ]],
[[                       ..                   ...   ]],
[[                       ..                 ...     ]],
[[                       ..        .      .'.       ]],
[[                   .   '.       ..   .',.         ]],
[[         ...       ..  ''     .'.  .,,.           ]],
[[           ...   .  ...;:'.'..,. .;;.             ]],
[[             ... ....:lolcllc;..;:'               ]],
[[              .',,,;codoodxko;;:'                 ]],
[[               .'clllodxoldxddo,....              ]],
[[              ..,oxddddl::coodoodo:.              ]],
[[            ..':ldkxxl'    'coolool:,'''''....    ]],
[[   .......',;:loooxxdc.    .;dxddddo:,'.......    ]],
[[             ..'clldddc,'.,cddddodd;...           ]],
[[               .,:coddoodddddoodl;,''..           ]],
[[             .....'.:oloddoddllc,'.  ......       ]],
[[              .... .,'.,odocl;........   .....    ]],
[[            ...    ..  .lc;..;.  .  ....      ..  ]],
[[          ...          .;,'  .;.       ..         ]],
[[        ...            .'..   .,.                 ]],
[[      ..               ...     .,.                ]],
[[     .                 ...       '.               ]],
[[                        .         ..              ]],
[[                                   ..             ]],
}
  end

return settings
