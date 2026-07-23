return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup()
		require("nvim-treesitter").install({
			"c",
			"html",
			"css",
			"lua",
			"typescript",
			"tsx", -- 👈 parser separado, necesario para .tsx (JSX dentro de TS)
			"javascript",
			"markdown",
			"markdown_inline",
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"c",
				"html",
				"css",
				"lua",
				"typescript",
				"typescriptreact", -- 👈 filetype real de .tsx
				"javascript",
				"javascriptreact", -- 👈 filetype real de .jsx
				"markdown",
			},
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
