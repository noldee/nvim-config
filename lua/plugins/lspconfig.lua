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
							hint = {
								enable = true,
							},
						},
					},
				},
				clangd = {
					cmd = {
						"clangd",
						"--inlay-hints",
						"--header-insertion=iwyu",
					},
				},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							inlayHints = {
								bindingModeHints = { enable = true },
								closureReturnTypeHints = { enable = "always" },
								parameterHints = { enable = true },
								typeHints = { enable = true },
							},
						},
					},
				},
				vtsls = {
					settings = {
						typescript = {
							inlayHints = {
								parameterNames = { enabled = "all" },
								parameterTypes = { enabled = true },
								variableTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								enumMemberValues = { enabled = true },
							},
						},
						javascript = {
							inlayHints = {
								parameterNames = { enabled = "all" },
								parameterTypes = { enabled = true },
								variableTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								enumMemberValues = { enabled = true },
							},
						},
					},
				},
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
