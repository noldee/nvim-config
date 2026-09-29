return {
	-- Tu terminal integrada como la tienes configurada
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				dir = "git_dir",
				shade_terminals = false,
				direction = "float",
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
				open_mapping = [[<c-\>]],
				start_in_insert = true,
				persist_size = true,
				close_on_exit = true,
			})
		end,
	},

	-- AGREGA ESTO AQUÍ: Inyecta Dressing para forzar menús tipo buscador de Telescope
	{
		"stevearc/dressing.nvim",
		lazy = false, -- Lo cargamos desde el inicio para interceptar el LSP
		opts = {
			input = { enabled = true },
			select = {
				enabled = true,
				backend = { "telescope", "builtin" }, -- Intenta usar Telescope por defecto
				telescope = require('telescope.themes').get_dropdown({
					layout_config = {
						width = 0.6,
						height = 0.4,
					},
				}),
			},
		},
	},
}

