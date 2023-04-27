local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

	-- Override plugin definition options

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},

	-- override plugin configs
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},
	{
		"mfussenegger/nvim-dap",
	},
	{
		"hrsh7th/cmp-nvim-lsp-signature-help",
		event = "LspAttach",
		config = function()
			require("cmp").setup.buffer({
				sources = {
					{ name = "nvim_lsp_signature_help" },
				},
			})
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		config = function()
			local path = require("mason-core.path")

			local root_path = path.concat({ vim.fn.stdpath("data"), "mason" })
			local codelldb = root_path .. "packages/codelldb/extension/adapter/codelldb"
			local liblldb = root_path .. "packages/codelldb/extension/lldb/lib/liblldb.so"

			require("rust-tools").setup({
				dap = {
					adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb, liblldb),
				},
			})

			local dap = require("dap")
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = codelldb,
					args = { "--port", "${port}" },
				},
			}
			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}
			dap.configurations.c = dap.configurations.cpp
			dap.configurations.rust = dap.configurations.cpp
			-- rt.inlay_hints.enable()
		end,
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
			vim.api.nvim_create_autocmd("BufRead", {
				group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
				pattern = "Cargo.toml",
				callback = function()
					require("cmp").setup.buffer({ sources = { { name = "crates" } } })
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
		config = function()
			vim.g.transparent_enabled = true
			require("transparent").setup({
				groups = { -- table: default groups
					"Normal",
					"NormalNC",
					"Comment",
					"Constant",
					"Special",
					"Identifier",
					"Statement",
					"PreProc",
					"Type",
					"Underlined",
					"Todo",
					"String",
					"Function",
					"Conditional",
					"Repeat",
					"Operator",
					"Structure",
					"LineNr",
					"NonText",
					"SignColumn",
					"CursorLineNr",
					"EndOfBuffer",
				},
				extra_groups = {}, -- table: additional groups that should be cleared
				exclude_groups = {
					"LspFloatWinNormal",
					"NormalFloat",
					"FloatBorder",
					"TelescopeNormal",
					"TelescopeBorder",
					"TelescopePromptBorder",
					"DapUINormal",
					"DapUINormalNC",
				}, -- table: groups you don't want to clear
			})
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},
	{
		"dnlhc/glance.nvim",
		event = "LspAttach",
		config = function()
			require("glance").setup({ detached = false, border = { enable = true } })
			local wk = require("which-key")
			wk.register({
				t = {
					d = { "<CMD>Glance references<CR>", "peek definition" },
					y = { "<CMD>Glance type_definitions<CR>", "peek type definition" },
					m = { "<CMD>Glance implementations<CR>", "peek implementations" },
				},
			}, { prefix = "<leader>" })
		end,
	},
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},
	{ "ray-x/lsp_signature.nvim", event = "LspAttach" },
	{
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		event = "LspAttach",
		config = function()
			require("trouble").setup({})
			local wk = require("which-key")
			wk.register({
				t = {
					t = { "<cmd>TroubleToggle<cr>", "toggle trouble view" },
				},
			}, { prefix = "<leader>" })
		end,
	},
	{
		"scalameta/nvim-metals",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = { "scala", "sbt" },
		config = function()
			-------------------------------------------------------------------------------
			-- These are example settings to use with nvim-metals and the nvim built-in
			-- LSP. Be sure to thoroughly read the `:help nvim-metals` docs to get an
			-- idea of what everything does. Again, these are meant to serve as an example,
			-- if you just copy pasta them, then should work,  but hopefully after time
			-- goes on you'll cater them to your own liking especially since some of the stuff
			-- in here is just an example, not what you probably want your setup to be.
			--
			-- Unfamiliar with Lua and Neovim?
			--  - Check out https://github.com/nanotee/nvim-lua-guide
			--
			-- The below configuration also makes use of the following plugins besides
			-- nvim-metals, and therefore is a bit opinionated:
			--
			-- - https://github.com/hrsh7th/nvim-cmp
			--   - hrsh7th/cmp-nvim-lsp for lsp completion sources
			--   - hrsh7th/cmp-vsnip for snippet sources
			--   - hrsh7th/vim-vsnip for snippet sources
			--
			-- - https://github.com/wbthomason/packer.nvim for package management
			-- - https://github.com/mfussenegger/nvim-dap (for debugging)
			-------------------------------------------------------------------------------
			local api = vim.api
			-- local cmd = vim.cmd
			-- local map = vim.keymap.set

			----------------------------------
			-- LSP Setup ---------------------
			----------------------------------
			local metals_config = require("metals").bare_config()

			-- Example of settings
			metals_config.settings = {
				showImplicitArguments = true,
				excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
			}

			-- *READ THIS*
			-- I *highly* recommend setting statusBarProvider to true, however if you do,
			-- you *have* to have a setting to display this in your statusline or else
			-- you'll not see any messages from metals. There is more info in the help
			-- docs about this
			-- metals_config.init_options.statusBarProvider = "on"

			-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
			metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Debug settings if you're using nvim-dap
			-- local dap = require("dap")
			--
			-- dap.configurations.scala = {
			--   {
			--     type = "scala",
			--     request = "launch",
			--     name = "RunOrTest",
			--     metals = {
			--       runType = "runOrTestFile",
			--       --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
			--     },
			--   },
			--   {
			--     type = "scala",
			--     request = "launch",
			--     name = "Test Target",
			--     metals = {
			--       runType = "testTarget",
			--     },
			--   },
			-- }
			--
			-- metals_config.on_attach = function(client, bufnr)
			--   require("metals").setup_dap()
			-- end
			--
			-- Autocmd that will actually be in charging of starting the whole thing
			local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
			api.nvim_create_autocmd("FileType", {
				-- NOTE: You may or may not want java included here. You will need it if you
				-- want basic Java support but it may also conflict if you are using
				-- something like nvim-jdtls which also works on a java filetype autocmd.
				pattern = { "scala", "sbt", "java" },
				callback = function()
					require("metals").initialize_or_attach(metals_config)
				end,
				group = nvim_metals_group,
			})
		end,
	},

	-- smooth scrolling
	{ "karb94/neoscroll.nvim", lazy = false, config = true },

	-- To make a plugin not be loaded
	-- {
	--   "NvChad/nvim-colorizer.lua",
	--   enabled = false
	-- },
}

return plugins
