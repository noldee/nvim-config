return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	opts = {
		background_colour = "#1c1c1c",
		render = "compact",
		stages = "static",
		timeout = 1000,
		top_down = true,
		max_width = 60,
		icons = {
			ERROR = "",
			WARN = "",
			INFO = "",
			DEBUG = "",
			TRACE = "✎",
		},
	},
	config = function(_, opts)
		local notify = require("notify")
		notify.setup(opts)
		vim.notify = notify

		notify("Welcome Back Sr 7w7", "info", { title = "Neovim" })
	end,
}
