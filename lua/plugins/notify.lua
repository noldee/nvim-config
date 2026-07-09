return {
	"rcarriga/nvim-notify",

	config = function()
		local notify = require("notify")

		vim.notify = notify

		notify("Welcome Back Sr 7w7")
	end,
}
