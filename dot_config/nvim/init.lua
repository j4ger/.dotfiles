-- neovide config
vim.g.neovide_refresh_rate = 240
vim.g.neovide_transparency = 0.75
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_fullscreen = true

-- appearance tweaks
vim.o.guifont = "Fira Code Retina:h10,Noto Sans CJK SC:h10"
vim.wo.number = true
vim.wo.relativenumber = true

-- autoread
vim.g.autoread = true

-- plugins
require("jetpack").setup({
	"kyazdani42/nvim-web-devicons",
	{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
	"romgrk/nvim-treesitter-context",
	"kyazdani42/nvim-tree.lua",
	"folke/which-key.nvim",
	"itchyny/lightline.vim",
	"alvarosevilla95/luatab.nvim",
	"arcticicestudio/nord-vim",
	"sunjon/shade.nvim",
	"akinsho/toggleterm.nvim",
	"https://gitlab.com/yorickpeterse/nvim-window.git",
	"neovim/nvim-lspconfig",
	"j-hui/fidget.nvim",
	"tami5/lspsaga.nvim",
	"nvim-lua/lsp_extensions.nvim",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-vsnip",
	"hrsh7th/vim-vsnip",
	"hrsh7th/vim-vsnip-integ",
	"onsails/lspkind-nvim",
	"sbdchd/neoformat",
	"ggandor/lightspeed.nvim",
	{
		"junegunn/fzf",
		run = ":call fzf#install()",
	},
	"junegunn/fzf.vim",
	"rafamadriz/friendly-snippets",
})
require("jetpack").optimization = 1

-- fzf action
vim.g.fzf_action = {
	enter = "tab split",
	["ctrl-x"] = "split",
	["ctrl-v"] = "vsplit",
}

-- LSP configs
require("fidget").setup({})

require("lspsaga").setup({})

-- completion configs
local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable,
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			elseif has_words_before() then
				cmp.complete()
			else
				fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" },
		{ name = "path" },
	}, {
		{ name = "buffer" },
	}),
	formatting = {
		format = require("lspkind").cmp_format({
			mode = "symbol_text",
			maxwidth = 50,
		}),
	},
})

-- configuration for specific filetypes
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" },
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- setup lspconfig and formatter
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- format on save
vim.api.nvim_exec(
	[[
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
]],
	true
)

-- lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lspconfig").sumneko_lua.setup({
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = runtime_path,
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
	capabilities = capabilities,
})

-- typescript, javascript
require("lspconfig").tsserver.setup({
	capabilities = capabilities,
})

-- vue
require("lspconfig").volar.setup({
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
	capabilities = capabilities,
})
vim.g.vsnip_filetypes = {
	vue = { "javascript", "html" },
}

-- file tree
require("nvim-tree").setup({
	view = {
		mappings = {
			list = {
				{ key = "<CR>", action = "tabnew" },
			},
		},
	},
})

-- nvim-window config
require("nvim-window").setup({
	chars = {
		"1",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8",
		"9",
		"a",
		"b",
		"c",
		"d",
		"e",
		"f",
	},
})

-- terminal configs (with lazygit integration)
local Terminal = require("toggleterm.terminal").Terminal

function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local lazygit = Terminal:new({
	cmd = "lazygit",
	dir = "git_dir",
	direction = "float",
	float_opts = {
		border = "double",
	},
})

function _lazygit_toggle()
	lazygit:toggle()
end

-- tabline
vim.cmd([[au ColorScheme * hi TabLine gui=none guibg='#4C566A' guifg='#5C6370']])
vim.cmd([[au ColorScheme * hi TabLineSel guibg='#4C566A' guifg='#282C34']])
vim.cmd([[au ColorScheme * hi TabLineFill guibg='#4C566A' ]])
require("luatab").setup({})

-- keybindings
vim.g.mapleader = " "

local whichkey = require("which-key")

whichkey.register({
	f = {
		name = "file tree",
		o = { "<cmd>NvimTreeToggle<cr>", "toggle file tree" },
		t = { "<cmd>NvimTreeFocus<cr>", "focus file tree" },
		f = { "<cmd>Files<cr>", "show fzf files" },
	},
	t = {
		name = "terminal",
		o = { "<cmd>ToggleTerm direction=tab<cr>", "open terminal as separate tab" },
		v = { "<cmd>ToggleTerm direction=vertical<cr>", "open terminal vertically" },
		w = { "<cmd>ToggleTerm direction=horizontal<cr>", "open terminal horizontally" },
	},
	g = {
		name = "git",
		l = { "<cmd>lua _lazygit_toggle()<cr>", "open lazygit" },
	},
	w = {
		name = "window",
		s = { "<cmd>lua require('nvim-window').pick()<cr>", "open window switcher" },
		d = { "<cmd>close<cr>", "close current window" },
	},
	l = {
		name = "LSP actions",
		r = { "<cmd>Lspsaga rename<cr>", "rename" },
		a = { "<cmd>Lspsaga code_action<cr>", "code action" },
		p = { "<cmd>lua require('lspsaga.provider').preview_definition()<cr>", "preview definition" },
		d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "go to definition" },
		c = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "go to declaration" },
		f = { "<cmd>Format<cr>", "format current buffer" },
	},
	b = {
		name = "buffers",
		d = { "<cmd>q<cr>", "close current buffer" },
	},
}, { prefix = "<leader>" })

whichkey.register({
	["<c-s>"] = { "<cmd>w<cr>", "save file" },
	q = { "<cmd>q<cr>", "quit" },
})

whichkey.register({
	["\\"] = {
		name = "tabs",
		["1"] = { "<cmd>tabn 1<cr>", "switch to tab 1" },
		["2"] = { "<cmd>tabn 2<cr>", "switch to tab 2" },
		["3"] = { "<cmd>tabn 3<cr>", "switch to tab 3" },
		["4"] = { "<cmd>tabn 4<cr>", "switch to tab 4" },
		["5"] = { "<cmd>tabn 5<cr>", "switch to tab 5" },
		["6"] = { "<cmd>tabn 6<cr>", "switch to tab 6" },
		["7"] = { "<cmd>tabn 7<cr>", "switch to tab 7" },
		["8"] = { "<cmd>tabn 8<cr>", "switch to tab 8" },
		["9"] = { "<cmd>tabn 9<cr>", "switch to tab 9" },
		d = { "<cmd>q<cr>", "close current buffer" },
	},
})
-- color scheme
vim.cmd("colorscheme nord")
