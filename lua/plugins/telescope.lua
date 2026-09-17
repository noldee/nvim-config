return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({
			defaults = {
				-- ✅ Globally hide .git and other annoying folders
				file_ignore_patterns = {
					"^%.git/", -- everything inside .git/
					"node_modules/", -- optional
					"%.lock", -- optional (lazy-lock.json kept visible though)
				},
				layout_config = {
					horizontal = { preview_cutoff = 0 },
				},
			},
			pickers = {
				colorscheme = { enable_preview = true },
				find_files = {
					hidden = true, -- show dotfiles like .env
					-- no_ignore removed ✅
				},
				live_grep = {
					additional_args = function(_)
						return { "--hidden" } -- no --no-ignore ✅
					end,
				},
			},
		})
	end,
}
