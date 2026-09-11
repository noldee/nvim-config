return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({
			pickers = {
				colorscheme = { enable_preview = true },
				-- Configuración para buscar archivos (incluye .env y ocultos)
				find_files = {
					hidden = true, -- Muestra archivos que empiezan con punto (.)
					no_ignore = true, -- Muestra archivos listados en el .gitignore
				},
				-- Configuración para buscar texto dentro de archivos
				live_grep = {
					additional_args = function(_)
						return { "--hidden", "--no-ignore" }
					end,
				},
			},
			defaults = {
				layout_config = {
					horizontal = { preview_cutoff = 0 },
				},
			},
		})
	end,
}
