return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({
			pickers = {
				colorscheme = { enable_preview = true },
			},
			defaults = {
				layout_config = {
					horizontal = { preview_cutoff = 0 },
				},
			},
		})
	end,
}
