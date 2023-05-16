return {
	-- You can also add new plugins here as well:
	-- Add plugins, the lazy syntax
	-- "andweeb/presence.nvim",
	-- {
	--   "ray-x/lsp_signature.nvim",
	--   event = "BufRead",
	--   config = function()
	--     require("lsp_signature").setup()
	--   end,
	-- },
	{
		"gbprod/nord.nvim",
		lazy = false,
		config = function()
			require("nord").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				transparent = false, -- Enable this to disable setting the background color
				terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
				diff = { mode = "bg" }, -- enables/disables colorful backgrounds when used in diff mode. values : [bg|fg]
				borders = true, -- Enable the border between verticaly split windows visible
				errors = { mode = "bg" }, -- Display mode for errors and diagnostics
				-- values : [bg|fg|none]
				styles = {
					-- Style to be applied to different syntax groups
					-- Value is any valid attr-list value for `:help nvim_set_hl`
					comments = { italic = true },
					keywords = {},
					functions = {},
					variables = {},

					-- To customize lualine/bufferline
					bufferline = {
						current = {},
						modified = { italic = true },
					},
				},

				-- colorblind mode
				-- see https://github.com/EdenEast/nightfox.nvim#colorblind
				-- simulation mode has not been implemented yet.
				colorblind = {
					enable = false,
					preserve_background = false,
					severity = {
						protan = 0.0,
						deutan = 0.0,
						tritan = 0.0,
					},
				},

				--- You can override specific highlights to use other groups or a hex color
				--- function will be called with all highlights and the colorScheme table
				on_highlights = function(highlights, colors) end,
			})
		end,
	},
	{ "SergioRibera/vim-screenshot", build = "npm install --prefix Renderizer", event = "BufEnter" },
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					auto_refresh = true,
					keymap = { open = "<S-Space>" },
				},
			})
		end,
	},
	{ "folke/trouble.nvim", event = "BufEnter" },
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		config = function()
			local path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/") or ""
			local codelldb_path = path .. "adapter/codelldb"
			local liblldb_path = path .. "lldb/lib/liblldb.so"

			require("rust-tools").setup({
				dap = {
					adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
				},
			})
		end,
	},
	{
		"scalameta/nvim-metals",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = "scala",
		config = function()
			local api = vim.api
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
			local dap = require("dap")

			dap.configurations.scala = {
				{
					type = "scala",
					request = "launch",
					name = "RunOrTest",
					metals = {
						runType = "runOrTestFile",
						--args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
					},
				},
				{
					type = "scala",
					request = "launch",
					name = "Test Target",
					metals = {
						runType = "testTarget",
					},
				},
			}

			metals_config.on_attach = function(client, bufnr)
				require("metals").setup_dap()
			end

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
}
