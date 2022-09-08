-- neovide config
vim.g.neovide_refresh_rate = 240
vim.g.neovide_transparency = 0.75
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_fullscreen = true

-- appearance tweaks
vim.o.guifont = "FiraCode Nerd Font Mono:h16,Noto Sans Mono CJK SC:h16"
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.laststatus = 3

-- autoread
vim.g.autoread = true

-- allow mouse
vim.o.mouse = "a"

-- plugins
require("jetpack").setup({
	"nvim-lua/plenary.nvim",
	"kyazdani42/nvim-web-devicons",
	{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
	"nvim-treesitter/nvim-treesitter-textobjects",
	"wellle/context.vim",
	"ray-x/lsp_signature.nvim",
	"folke/which-key.nvim",
	"itchyny/lightline.vim",
	"alvarosevilla95/luatab.nvim",
	"arcticicestudio/nord-vim",
	"sunjon/shade.nvim",
	"https://gitlab.com/yorickpeterse/nvim-window.git",
	"neovim/nvim-lspconfig",
	"j-hui/fidget.nvim",
	"tami5/lspsaga.nvim",
	"nvim-lua/lsp_extensions.nvim",
	"luukvbaal/nnn.nvim",
	--[[ "hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-vsnip",
	"hrsh7th/vim-vsnip",
	"hrsh7th/vim-vsnip-integ", ]]
	{ "ms-jpq/coq_nvim", branch = "coq" },
	{ "ms-jpq/coq.artifacts", branch = "artifacts" },
	"onsails/lspkind-nvim",
	"jose-elias-alvarez/null-ls.nvim",
	"ggandor/lightspeed.nvim",
	"b3nj5m1n/kommentary",
	"windwp/nvim-ts-autotag",
	"windwp/nvim-autopairs",
	"ibhagwan/fzf-lua",
	"rafamadriz/friendly-snippets",
	"abecodes/tabout.nvim",
	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	"folke/trouble.nvim",
	"folke/twilight.nvim",
	"tpope/vim-surround",
	"jose-elias-alvarez/nvim-lsp-ts-utils",
	"m-demare/hlargs.nvim",
	"tversteeg/registers.nvim",
	"winston0410/range-highlight.nvim",
	"simrat39/rust-tools.nvim",
	"lvimuser/lsp-inlayhints.nvim",
})
require("jetpack").optimization = 1

-- fzf actions
local actions = require("fzf-lua.actions")
require("fzf-lua").setup({
	actions = {
		files = {
			["default"] = actions.file_tabedit,
			["ctrl-s"] = actions.file_split,
			["ctrl-v"] = actions.file_vsplit,
		},
		buffers = {
			["default"] = actions.buf_edit,
			["ctrl-s"] = actions.buf_split,
			["ctrl-v"] = actions.buf_vsplit,
		},
	},
	lsp = {
		async_or_timeout = 3000,
	},
})

-- auto close tag & brackets
require("nvim-ts-autotag").setup({})
require("nvim-autopairs").setup({})
-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")

-- enable echodoc
vim.g.echodoc_enable_at_startup = true

-- LSP configs
require("fidget").setup({})

require("lspsaga").setup({})

--[[ -- completion configs
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
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			else
				fallback()
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

-- auto pair within completion
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

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
}) ]]

-- tabout config
require("tabout").setup({})

-- trouble list
require("trouble").setup({})

-- treesitter config
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	textobjects = {
		select = {
			enable = true,

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		lsp_interop = {
			enable = true,
			border = "none",
			peek_definition_code = {
				["<leader>df"] = "@function.outer",
				["<leader>dF"] = "@class.outer",
			},
		},
	},
})

-- setup lspconfig, formatter and signature display
require("lsp_signature").setup({})

local lspconfig = require("lspconfig")
local coq = require("coq")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.code_actions.xo,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.verible_verilog_format,
		null_ls.builtins.formatting.taplo,
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.rustfmt.with({
			extra_args = { "--edition=2021" },
		}),
		null_ls.builtins.formatting.black,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
						filter = function(current_client)
							return current_client.name == "null-ls"
						end,
					})
				end,
			})
		end
	end,
})

require("twilight").setup({})
vim.api.nvim_exec(
	[[
autocmd VimEnter * Twilight
]],
	true
)

require("hlargs").setup({})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- rust
local rust_tools = require("rust-tools")
rust_tools.setup({
	autoSetHints = false,
	server = coq.lsp_ensure_capabilities({
		on_attach = function(_, bufnr)
			-- Hover actions
			vim.keymap.set("n", "<C-space>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
			-- Code action groups
			vim.keymap.set("n", "<Leader>a", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
		end,
		capabilities = capabilities,
	}),
})

-- python
lspconfig.pyright.setup(coq.lsp_ensure_capabilities({}))

-- c,cpp
lspconfig.clangd.setup(coq.lsp_ensure_capabilities({}))

-- lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup(coq.lsp_ensure_capabilities({
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
}))

-- html
require("lspconfig").html.setup(coq.lsp_ensure_capabilities({ capabilities = capabilities }))

-- typescript, javascript
lspconfig.tsserver.setup(coq.lsp_ensure_capabilities({
	init_options = require("nvim-lsp-ts-utils").init_options,
	on_attach = function(client)
		local ts_utils = require("nvim-lsp-ts-utils")

		-- defaults
		ts_utils.setup({
			debug = false,
			disable_commands = false,
			enable_import_on_completion = false,

			-- import all
			import_all_timeout = 5000, -- ms
			-- lower numbers = higher priority
			import_all_priorities = {
				same_file = 1, -- add to existing import statement
				local_files = 2, -- git files or files with relative path markers
				buffer_content = 3, -- loaded buffer content
				buffers = 4, -- loaded buffer names
			},
			import_all_scan_buffers = 100,
			import_all_select_source = false,
			-- if false will avoid organizing imports
			always_organize_imports = true,

			-- filter diagnostics
			filter_out_diagnostics_by_severity = {},
			filter_out_diagnostics_by_code = {},

			-- inlay hints
			auto_inlay_hints = true,
			inlay_hints_highlight = "Comment",
			inlay_hints_priority = 200, -- priority of the hint extmarks
			inlay_hints_throttle = 150, -- throttle the inlay hint request
			inlay_hints_format = { -- format options for individual hint kind
				Type = {},
				Parameter = {},
				Enum = {},
				-- Example format customization for `Type` kind:
				-- Type = {
				--     highlight = "Comment",
				--     text = function(text)
				--         return "->" .. text:sub(2)
				--     end,
				-- },
			},

			-- update imports on file move
			update_imports_on_move = true,
			require_confirmation_on_move = false,
			watch_dir = nil,
		})

		-- required to fix code action ranges and filter diagnostics
		ts_utils.setup_client(client)
	end,
}))

-- vue
lspconfig.volar.setup(coq.lsp_ensure_capabilities({
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
}))
vim.g.vsnip_filetypes = {
	vue = { "javascript", "html" },
}

-- json
lspconfig.jsonls.setup(coq.lsp_ensure_capabilities({
	capabilities = capabilities,
}))

-- emmet
local configs = require("lspconfig.configs")

if not configs.ls_emmet then
	configs.ls_emmet = {
		default_config = {
			cmd = { "ls_emmet", "--stdio" },
			filetypes = {
				"html",
				"css",
				"scss",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"haml",
				"xml",
				"xsl",
				"pug",
				"slim",
				"sass",
				"stylus",
				"less",
				"sss",
				"hbs",
				"handlebars",
			},
			root_dir = function(fname)
				return vim.loop.cwd()
			end,
			settings = {},
		},
	}
end

lspconfig.ls_emmet.setup(coq.lsp_ensure_capabilities({}))

-- verilog
require("lspconfig").verible.setup(coq.lsp_ensure_capabilities({}))

-- bash
require("lspconfig").bashls.setup(coq.lsp_ensure_capabilities({}))

-- lsp lines
require("lsp_lines").setup()
vim.diagnostic.config({
	virtual_text = false,
})

-- inlay hints
require("lsp-inlayhints").setup()

-- file picker configs
require("fidget").setup({})
local nnn_builtin = require("nnn").builtin
require("nnn").setup({
	auto_open = {
		setup = "picker",
		tabpage = "picker", -- or "explorer" / "picker", auto open when opening new tabpage
		empty = true, -- only auto open on empty buffer
		ft_ignore = { -- dont auto open for these filetypes
			"gitcommit",
		},
	},
	auto_close = true, -- close tabpage/nvim when nnn is last window
	replace_netrw = "picker", -- or "explorer" / "picker"
	mappings = {
		{ "<cr>", nnn_builtin.open_in_tab }, -- open file(s) in tab
		{ "<C-s>", nnn_builtin.open_in_split }, -- open file(s) in split
		{ "<C-v>", nnn_builtin.open_in_vsplit }, -- open file(s) in vertical split
		{ "<C-p>", nnn_builtin.open_in_preview }, -- open file in preview split keeping nnn focused
		{ "<C-y>", nnn_builtin.copy_to_clipboard }, -- copy file(s) to clipboard
		{ "<C-w>", nnn_builtin.cd_to_path }, -- cd to file directory
		{ "<C-e>", nnn_builtin.populate_cmdline }, -- populate cmdline (:) with file(s)
	}, -- table containing mappings, see below
	windownav = { -- window movement mappings to navigate out of nnn
		left = "<C-w>h",
		right = "<C-w>l",
		next = "<C-w>w",
		prev = "<C-w>W",
	},
	buflisted = false, -- wether or not nnn buffers show up in the bufferlist
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
		o = { "<cmd>NnnPicker<cr>", "toggle file tree" },
		f = { "<cmd>lua require('fzf-lua').files()<cr>", "show fzf files" },
		g = { "<cmd>lua require('fzf-lua').live_grep()<cr>", "show fzf live grep" },
	},
	g = {
		name = "git",
		l = { "<cmd>lua _lazygit_toggle()<cr>", "open lazygit" },
	},
	w = { "<cmd>lua require('nvim-window').pick()<cr>", "open window switcher" },
	l = {
		name = "LSP actions",
		r = { "<cmd>Lspsaga rename<cr>", "rename" },
		a = { "<cmd>Lspsaga code_action<cr>", "code action" },
		p = { "<cmd>lua require('lspsaga.provider').preview_definition()<cr>", "preview definition" },
		d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "go to definition" },
		c = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "go to declaration" },
		f = { "<cmd>Format<cr>", "format current buffer" },
	},
	b = { "<cmd>lua require('fzf-lua').buffers()<cr>", "switch buffers" },
	e = {
		name = "trouble",
		o = { "<cmd>TroubleToggle<cr>", "toggle trouble" },
		r = { "<cmd>TroubleRefresh<cr>", "refresh trouble" },
	},
	q = { "<cmd>tabc<cr>", "close tab" },
}, { prefix = "<leader>" })

whichkey.register({
	["<c-s>"] = { "<cmd>w<cr>", "save file" },
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

-- start autocomplete
vim.cmd("COQnow")
