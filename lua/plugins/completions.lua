return {
	-- Plugin principal de autocompletado
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter", -- Carga el plugin al entrar en modo inserción
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- Fuente de autocompletado para LSP
			"hrsh7th/cmp-buffer", -- Fuente de autocompletado para el texto del buffer
			"hrsh7th/cmp-path", -- Fuente de autocompletado para rutas de archivos
			"L3MON4D3/LuaSnip", -- Motor de snippets
			"saadparwaiz1/cmp_luasnip", -- Integración de LuaSnip con cmp
			"rafamadriz/friendly-snippets", -- Colección de snippets útiles
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- Carga los snippets de VSCode
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				-- Configuración de snippets (necesaria para la integración)
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				-- Mapeo de teclas para navegar y confirmar el menú de sugerencias
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(), -- Forzar la apertura del menú
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }), -- Confirmar con Enter
					-- Navegación con Ctrl+j/k o Tab/Shift+Tab
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				-- Fuentes de autocompletado (el orden importa)
				sources = cmp.config.sources({
					{ name = "nvim_lsp" }, -- Prioridad 1: LSP
					{ name = "luasnip" }, -- Prioridad 2: Snippets
					{ name = "buffer" }, -- Prioridad 3: Texto del buffer
					{ name = "path" }, -- Prioridad 4: Rutas
				}),
			})
		end,
	},
}
