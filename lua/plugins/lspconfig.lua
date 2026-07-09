return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				},

				clangd = {},

				rust_analyzer = {},

				vtsls = {},

				tailwindcss = {},

				jdtls = {},

				marksman = {},

				astro = {},
			}

			for server, config in pairs(servers) do
				config.capabilities = capabilities
				vim.lsp.config(server, config)
			end

			vim.lsp.enable(vim.tbl_keys(servers))
		end,
	},
}
