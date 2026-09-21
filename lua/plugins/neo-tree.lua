return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"DaikyXendo/nvim-material-icon",
	},
	-- Keymaps are defined inside the config function to avoid lazy-loading race conditions
	config = function()
		-- Synchronize global root properties before executing setup
		require("neo-tree").setup({
			-- Keeps the Neo-tree root updated with the dynamic CWD handled in init.lua
			sync_root_with_cwd = true,

			window = {
				position = "left",
				width = 25, -- Compact width layout
			},
			filesystem = {
				-- Synchronizes the visual sidebar workspace tree with the active editor directory
				bind_to_cwd = true,

				follow_current_file = {
					enabled = true, -- The tree focuses on your currently active open buffer file
					leave_dirs_open = false,
				},
				filtered_items = {
					visible = false,
					hide_dotfiles = false,
					hide_gitignored = true,
					never_show = { ".git" },
				},
			},
		})

		-- Safe custom keymap binding interface
		-- Uses 'Neotree toggle' to cleanly open or close the explorer window with Space + e
		vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neo-tree" })
	end,
}
