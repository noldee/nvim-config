return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"DaikyXendo/nvim-material-icon",
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true, -- Muestra los archivos filtrados de forma tenue
					hide_dotfiles = false, -- Evita que se oculten los archivos que inician con punto (.)
					hide_gitignored = false, -- Evita que se oculten los archivos del .gitignore (como .env)
				},
			},
		})
	end,
}
