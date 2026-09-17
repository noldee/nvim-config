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
					visible = false, -- Hide "filtered" items
					hide_dotfiles = false, -- Show dotfiles (.env, .gitignore, etc.)
					hide_gitignored = true, -- ✅ Respect .gitignore
					never_show = { ".git" }, -- ✅ Never show .git
				},
			},
		})
	end,
}
