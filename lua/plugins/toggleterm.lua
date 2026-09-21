return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			-- Forces Toggleterm instances to follow the Git root path or active editor CWD
			dir = "git_dir",

			shade_terminals = false,
			direction = "float", -- Default layout used when invoking :ToggleTerm without sizing options
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return math.floor(vim.o.columns * 0.4)
				end
			end,
			float_opts = {
				border = "curved",
			},
			open_mapping = [[<c-\>]], -- Native plugin backup mapping (Ctrl+\) for fast execution toggling
			start_in_insert = true,
			persist_size = true,
			close_on_exit = true,
		})
	end,
}
