---@type MappingsTable
local M = {}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		["<leader>tD"] = {
			function()
				require("dapui").setup({})
				require("dapui").toggle()
			end,
			"toggle debug view",
		},
	},
}

-- more keybinds!

return M
