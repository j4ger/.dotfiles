vim.g.neovide_refresh_rate = 240
vim.g.neovide_transparency = 0.8
vim.g.neovide_cursor_vfx_mode = "pixiedust"

vim.o.guifont = "FiraCode Nerd Font Mono:h16,Noto Sans CJK SC:h18"
vim.wo.relativenumber = true

vim.g.autoread = true

vim.g.neovide_cursor_animation_length = 0.13

-- nvui configs
if vim.g.nvui then
	vim.cmd([[autocmd InsertEnter * NvuiIMEEnable]])
	vim.cmd([[autocmd InsertLeave * NvuiIMEDisable]])
end

-- fvim configs
vim.api.nvim_exec(
	[[
        if exists('g:fvim_loaded')
            " Ctrl-ScrollWheel for zooming in/out
            nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
            nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
            
            FVimCursorSmoothMove v:true
            FVimCursorSmoothBlink v:true

            FVimBackgroundComposition 'acrylic'
            FVimBackgroundOpacity 0.85
            FVimBackgroundAltOpacity 0.85

            FVimCustomTitleBar v:true
            
            FVimFontAntialias v:true
            FVimFontAutohint v:true
            FVimFontHintLevel 'full'
            FVimFontLigature v:true
            FVimFontSubpixel v:true

            FVimFontAutoSnap v:true

            FVimUIPopupMenu v:true
            FVimUIWildMenu v:true
        endif
]],
	true
)

-- keybindings
local whichkey = require("which-key")
whichkey.register({
	s = {
		"<cmd>:w<cr>",
		"Save File",
	},
	f = {
		"<Plug>(leap-forward)",
		"Leap Forward",
	},
	F = {
		"<Plug>(leap-backward)",
		"Leap Backward",
	},
})

-- format on save
vim.cmd([[
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
]])

-- rust-tools
require("rust-tools").setup({
	dap = {
		adapter = require("rust-tools.dap").get_codelldb_adapter(
			"/usr/bin/codelldb",
			"/usr/lib/codelldb/lldb/lib/liblldb.so"
		),
	},
})
