return {
	"DaikyXendo/nvim-material-icon",
	event = { "VeryLazy" },
	config = function()
		require("nvim-web-devicons").setup({
			color_icons = true,
			default = true,
		})
	end,
}
