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
				"javascript",
				"markdown",
			},
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
