return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto", -- o "tokyonight", "catppuccin", etc.
				section_separators = "", -- sin separadores (más limpio)
				component_separators = "",
				globalstatus = true, -- una sola barra global
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						"filename",
						path = 0,
						symbols = {
							modified = " ●",
							readonly = " ",
							unnamed = " ", -- X roja siempre (sin lógica condicional)
							newfile = "New",
						},
						color = { fg = "#ff5555" }, -- aplica a todo el componente
					},
				},
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
