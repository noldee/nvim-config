return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "night", -- "storm", "day", "moon" o "night"
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight") -- ✅ aquí se activa
		end,
	},
	-- Los otros dos los dejas comentados o los borras
	-- { "olimorris/onedarkpro.nvim", priority = 1000 },
	-- { "webhooked/kanso.nvim", lazy = false, priority = 1000 },
}
