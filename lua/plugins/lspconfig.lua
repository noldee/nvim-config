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
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"clangd",
				"rust_analyzer",
				"vtsls",
				"denols",
				"tailwindcss",
				"marksman",
				"astro",
				"svelte",
				"html",
				"emmet_language_server",
				"eslint",
				"jsonls",
				"prismals",
				"jdtls",
			},
			automatic_enable = false, -- lo habilitamos nosotros manualmente abajo
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- helper: existe deno.json/deno.jsonc en el proyecto?
			local function has_deno_config(bufnr)
				return vim.fs.find({ "deno.json", "deno.jsonc" }, {
					path = vim.api.nvim_buf_get_name(bufnr),
					upward = true,
				})[1] ~= nil
			end

			-- ✅ Configuración MODERADA de inlay hints (estilo LazyVim)
			local ts_inlay_hints = {
				includeInlayParameterNameHints = "literals", -- solo parámetros literales
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = false, -- ❌ sin tipos de variables (menos ruido)
				includeInlayVariableTypeHintsWhenTypeMatchesName = false,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = false, -- ❌ sin tipo de retorno
				includeInlayEnumMemberValueHints = true,
			}

			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = {
								version = "LuaJIT",
								path = { "lua/?.lua", "lua/?/init.lua" },
							},
							workspace = {
								checkThirdParty = false,
								library = {
									vim.env.VIMRUNTIME, -- ✅ runtime de Neovim
									vim.fn.expand("~/.config/nvim"), -- ✅ tu propia config
								},
							},
							diagnostics = { globals = { "vim" } },
							hint = { enable = true },
							telemetry = { enable = false },
						},
					},
				},

				clangd = {
					cmd = { "clangd", "--inlay-hints", "--header-insertion=iwyu" },
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
				-- vtsls: para Node/Bun/NestJS/etc (NO para proyectos Deno)
				vtsls = {
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
					},
					settings = {
						typescript = { inlayHints = ts_inlay_hints },
						javascript = { inlayHints = ts_inlay_hints },
					},
					on_new_config = function(config, root_dir)
						-- si hay deno.json en el root, no arranques vtsls
						if has_deno_config(vim.api.nvim_get_current_buf()) then
							config.enabled = false
						end
					end,
				},
				-- denols: solo para proyectos Deno
				denols = {
					root_dir = function(bufnr, on_dir)
						local found = vim.fs.find({ "deno.json", "deno.jsonc" }, {
							path = vim.api.nvim_buf_get_name(bufnr),
							upward = true,
						})[1]
						if found then
							on_dir(vim.fs.dirname(found))
						end
					end,
					settings = {
						deno = {
							enable = true,
							lint = true,
							unstable = true,
						},
					},
				},
				tailwindcss = {},
				marksman = {},
				astro = {
					init_options = {
						typescript = {
							tsdk = vim.fn.expand(
								"~/.local/share/nvim/mason/packages/astro-language-server/node_modules/typescript/lib"
							),
						},
					},
				},
				svelte = {},
				html = {},
				eslint = {},
				jsonls = {},
				prismals = {},
				jdtls = {},
				qmlls = {
					cmd = { "qmlls6" },
					filetypes = { "qml", "qmljs" },
					single_file_support = true,
				},
				emmet_language_server = {
					filetypes = {
						"html",
						"css",
						"astro",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"svelte",
						"vue",
					},
				},
			}

			for server, config in pairs(servers) do
				config.capabilities = capabilities
				vim.lsp.config(server, config)
			end
			vim.lsp.enable(vim.tbl_keys(servers))
		end,
	},
}
