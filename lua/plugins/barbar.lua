return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("barbar").setup({
			icons = {
				button = "X",
			},
		})

		-- Pinta la X de rojo
		vim.api.nvim_set_hl(0, "BufferCurrentButton", { fg = "#ff5555", bold = true })
		vim.api.nvim_set_hl(0, "BufferVisibleButton", { fg = "#ff5555", bold = true })
		vim.api.nvim_set_hl(0, "BufferInactiveButton", { fg = "#ff5555" })
	end,
}
