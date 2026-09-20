return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"DaikyXendo/nvim-material-icon",
	},
	keys = {
		-- Con 'toggle' abre si está cerrado, y lo cierra si está abierto
		{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
	},
	config = function()
		require("neo-tree").setup({
			window = {
				position = "left",
				width = 25, -- Ancho compacto
			},
			filesystem = {
				filtered_items = {
					visible = false,
					hide_dotfiles = false,
					hide_gitignored = true,
					never_show = { ".git" },
				},
			},
		})
	end,
}
