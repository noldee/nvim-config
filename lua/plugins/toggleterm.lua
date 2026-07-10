return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			shade_terminals = false,
			direction = "float", -- layout por defecto cuando usas :ToggleTerm sin argumentos
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
			open_mapping = [[<c-\>]], -- atajo extra nativo del plugin (Ctrl+\) para abrir/cerrar rápido
			start_in_insert = true,
			persist_size = true,
			close_on_exit = true,
		})
	end,
}
