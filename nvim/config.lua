--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "tokyonight"
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
	name = "+Trouble",
	r = { "<cmd>Trouble lsp_references<cr>", "References" },
	f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
	q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	l = { "<cmd>Trouble loclist<cr>", "LocationList" },
	w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.dap.active = true

-- Disable the builtin barbar
lvim.builtin.bufferline.active = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"javascript",
	"json",
	"lua",
	"python",
	"typescript",
	"css",
	"rust",
	"java",
	"yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { exe = "black", filetypes = { "python" } },
--   { exe = "isort", filetypes = { "python" } },
--   {
--     exe = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { exe = "flake8", filetypes = { "python" } },
--   {
--     exe = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     args = { "--severity", "warning" },
--   },
--   {
--     exe = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Lsp overrides configs
lvim.lsp.override = { "rust" }

-- Additional formatters
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "prettier",
		filetypes = { "typescript", "javascript", "vue", "json" },
	},
	{ exe = "stylua", filetypes = { "lua" } },
	{ exe = "black", filetypes = { "python" } },
})

-- Additional linters
-- local linters = require "lvim.lsp.null_ls.linters"
-- linters.setup {

-- }

-- Additional Plugins
lvim.plugins = {
	{ "folke/tokyonight.nvim" },
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	-- { "xiyaowong/nvim-transparent" },
	{
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
		config = function()
			require("neoscroll").setup({
				-- All these keys will be mapped to their corresponding default scrolling animation
				mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
				hide_cursor = true, -- Hide cursor while scrolling
				stop_eof = true, -- Stop at <EOF> when scrolling downwards
				use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
				respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
				cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
				easing_function = nil, -- Default easing function
				pre_hook = nil, -- Function to run before the scrolling animation starts
				post_hook = nil, -- Function to run after the scrolling animation ends
			})
		end,
	},
	{ "kdheepak/lazygit.nvim" },
	{
		"simrat39/rust-tools.nvim",
		config = function()
			require("rust-tools").setup({
				tools = {
					autoSetHints = true,
					hover_with_actions = true,
					runnables = {
						use_telescope = true,
					},
				},
				server = {
					cmd = { vim.fn.stdpath("data") .. "/lsp_servers/rust/rust-analyzer" },
					on_attach = require("lvim.lsp").common_on_attach,
					on_init = require("lvim.lsp").common_on_init,
				},
			})
		end,
		ft = { "rust", "rs" },
	},
	{
		"turbio/bracey.vim",
		cmd = { "Bracey", "BracyStop", "BraceyReload", "BraceyEval" },
		run = "npm install --prefix server",
	},
	-- Tabout doesn't seem to be working for now alongside Copilot and nvim-cmp
	-- {
	-- 	"abecodes/tabout.nvim",
	-- 	config = function()
	-- 		require("tabout").setup({
	-- 			tabkey = "", -- key to trigger tabout, set to an empty string to disable
	-- 			backwards_tabkey = "", -- key to trigger backwards tabout, set to an empty string to disable
	-- 			act_as_tab = true, -- shift content if tab out is not possible
	-- 			act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
	-- 			enable_backwards = true, -- well ...
	-- 			completion = false, -- if the tabkey is used in a completion pum
	-- 			tabouts = {
	-- 				{ open = "'", close = "'" },
	-- 				{ open = '"', close = '"' },
	-- 				{ open = "`", close = "`" },
	-- 				{ open = "(", close = ")" },
	-- 				{ open = "[", close = "]" },
	-- 				{ open = "{", close = "}" },
	-- 			},
	-- 			ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
	-- 			exclude = {}, -- tabout will ignore these filetypes
	-- 		})
	-- 	end,
	-- 	requires = { "nvim-treesitter" },
	-- },
	{
		"sindrets/diffview.nvim",
		event = "BufRead",
	},
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_no_tab_map = true
			vim.g.copilot_assume_mapped = true
			vim.g.copilot_tab_fallback = ""
		end,
	},

	-- {
	-- 	"alvarosevilla95/luatab.nvim",
	-- 	requires = { "kyazdani42/nvim-web-devicons" },
	-- 	config = function()
	-- 		require("luatab").setup({})
	-- 	end,
	-- },
	-- {
	-- 	"filipdutescu/renamer.nvim",
	-- 	branch = "master",
	-- 	requires = { { "nvim-lua/plenary.nvim" } },
	-- 	config = function()
	-- 		require("renamer").setup({
	-- 			empty = false,
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	"wfxr/minimap.vim",
	-- 	run = "cargo install --locked code-minimap",
	-- 	-- cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
	-- 	config = function()
	-- 		vim.cmd("let g:minimap_width = 25")
	-- 		vim.cmd("let g:minimap_auto_start = 1")
	-- 		-- vim.cmd("let g:minimap_auto_start_win_enter = 1")
	-- 	end,
	-- },
}

-- Let Copilot work with nvim-cmp
-- wait a sec this still don't work when no suggestion is present
local cmp = require("cmp")
lvim.builtin.cmp.mapping["<Tab>"] = cmp.mapping(function(fallback)
	local luasnip = require("luasnip")
	local copilot_key = vim.fn["copilot#Accept"]("")
	if cmp.visible() then
		cmp.select_next_item()
	elseif luasnip and luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	elseif copilot_key ~= "" then
		vim.api.nvim_feedkeys(copilot_key, "i", true)
	else
		fallback()
	end
end)

-- Fix tab clash issue between Copilot and nvim-cmp
-- Credit: https://github.com/Dan-M/dotfiles/blob/0873c54f2b/.config/lvim/lua/user/lvimconfig.lua
-- local coreCmp = require("lvim.core.cmp")

-- -- Definitions for custom tab and shift_tab functions
-- function tab(fallback)
-- 	local methods = coreCmp.methods
-- 	local cmp = require("cmp")
-- 	local luasnip = require("luasnip")
-- 	local copilot_keys = vim.fn["copilot#Accept"]()
-- 	if cmp.visible() then
-- 		cmp.select_next_item()
-- 	elseif vim.api.nvim_get_mode().mode == "c" then
-- 		fallback()
-- 	elseif copilot_keys ~= "" then -- prioritise copilot over snippets
-- 		-- Copilot keys do not need to be wrapped in termcodes
-- 		vim.api.nvim_feedkeys(copilot_keys, "i", true)
-- 	elseif luasnip.expandable() then
-- 		luasnip.expand()
-- 	elseif methods.jumpable() then
-- 		luasnip.jump(1)
-- 	elseif methods.check_backspace() then
-- 		fallback()
-- 	else
-- 		methods.feedkeys("<Plug>(Tabout)", "")
-- 	end
-- end

-- function shift_tab(fallback)
-- 	local methods = coreCmp.methods
-- 	local luasnip = require("luasnip")
-- 	local cmp = require("cmp")
-- 	if cmp.visible() then
-- 		cmp.select_prev_item()
-- 	elseif vim.api.nvim_get_mode().mode == "c" then
-- 		fallback()
-- 	elseif methods.jumpable(-1) then
-- 		luasnip.jump(-1)
-- 	else
-- 		local copilot_keys = vim.fn["copilot#Accept"]()
-- 		if copilot_keys ~= "" then
-- 			methods.feedkeys(copilot_keys, "i")
-- 		else
-- 			methods.feedkeys("<Plug>(Tabout)", "")
-- 		end
-- 	end
-- end

-- local cmp = require("cmp")
-- lvim.builtin.cmp.mapping["<Tab>"] = cmp.mapping(tab, { "i", "c" })
-- lvim.builtin.cmp.mapping["<S-Tab>"] = cmp.mapping(shift_tab, { "i", "c" })

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

-- Set background_colour to transparent by default
-- vim.g.transparent_enabled = true

-- Set the theme for lualine
-- vim.cmd("source ~/.dotfiles/nvim/evil_lualine.lua")
lvim.builtin.lualine.options.theme = "tokyonight"

-- Set custom startup text
lvim.builtin.dashboard.custom_header = {
	"          ⢠⣿⣶⣄⣀⡀              ",
	"⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣦⣄⣀⡀⣠⣾⡇⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀",
	"⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⢿⣿⣿⡇⠀⠀⠀⠀",
	"⠀⣶⣿⣦⣜⣿⣿⣿⡟⠻⣿⣿⣿⣿⣿⣿⣿⡿⢿⡏⣴⣺⣦⣙⣿⣷⣄⠀⠀⠀",
	"⠀⣯⡇⣻⣿⣿⣿⣿⣷⣾⣿⣬⣥⣭⣽⣿⣿⣧⣼⡇⣯⣇⣹⣿⣿⣿⣿⣧⠀⠀",
	" ⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠸⣿⣿⣿⣿⣿⣿⣿⣷ ",
}
