return {
	{ "simrat39/rust-tools.nvim" },
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").setup({})
		end,
	},
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"IndianBoy42/tree-sitter-just",
		config = function()
			require("tree-sitter-just").setup({})
		end,
	},
}
