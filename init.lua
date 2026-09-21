-- =============================================================================
-- 1. DISABLE NETRW (Prevents conflicts with Neo-tree in Neovim 0.11+)
-- =============================================================================
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- =============================================================================
-- 2. BASE CONFIGURATIONS AND PREFERENCES
-- =============================================================================
require("keymaps")
require("preferences")
require("config.options")

-- =============================================================================
-- 3. LAZY.NVIM BOOTSTRAP (Plugin Manager)
-- =============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "plugins" },
})

-- =============================================================================
-- 4. DIAGNOSTICS CONFIGURATION (LSP)
-- =============================================================================
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		spacing = 4,
		source = "if_many",
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
	},
})

-- =============================================================================
-- 5. AUTOMATIC EVENTS (Autocmds)
-- =============================================================================

-- Inlay hints (Inline parameter names/types for clear code readability)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
		end
	end,
})

-- DIRECTORY ENTRY FIX: Automatically opens Neo-tree and syncs CWD on launch
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("NeoTreeInitOnDir", { clear = true }),
	callback = function()
		local bufname = vim.api.nvim_buf_get_name(0)
		local stats = vim.uv.fs_stat(bufname)

		if stats and stats.type == "directory" then
			-- Update Neovim's global current working directory to the target directory
			vim.fn.chdir(bufname)

			-- Schedule execution to let lazy.nvim complete plugin loads and avoid visual errors
			vim.schedule(function()
				local ok, neotree = pcall(require, "neo-tree.command")
				if ok then
					neotree.execute({ action = "show", dir = bufname })
				end
			end)
		end
	end,
})
