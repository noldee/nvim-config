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
			"tsx",
			"javascript",
			"markdown",
			"markdown_inline",
			"java",
			"svelte",
			"astro",
			"go",
			"bash",
			"json",
			"qmljs",
		})
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"c",
				"html",
				"css",
				"lua",
				"typescript",
				"typescriptreact",
				"javascript",
				"javascriptreact",
				"markdown",
				"svelte",
				"astro",
				"go",
				"bash",
				"json",
				"qmljs",
				"java",
			},
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
