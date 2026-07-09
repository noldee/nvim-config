return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠴⠒⠚⠉⣉⣙⡒⠲⠤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠋⣠⠔⣶⣾⣦⣌⣋⣙⣿⣷⣦⣉⠳⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠋⠀⠀⣠⠊⠰⣿⣿⣿⣿⣿⣇⠙⣿⣿⣦⡙⢦⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⠃⠀⢀⠈⠁⠀⢰⣿⠉⢿⣿⡟⣿⣧⠘⣿⢻⣷⠸⡄⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠁⠀⠀⠀⢀⣼⠀⠀⣿⠀⠘⣿⡇⢻⣿⣆⢹⡄⢿⡇⢧⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠃⠀⢠⠀⢠⣟⡃⢸⠃⠹⠀⢧⠸⡷⠘⣿⣿⠀⡇⢸⡇⢸⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡇⠀⠘⠀⣿⣿⣿⣨⣶⠀⢸⣦⣄⠀⠀⣿⣿⠀⠇⣾⡇⠸⡄⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⠁⢀⠀⣯⢉⠀⢹⣿⣧⡸⠿⢿⡄⠀⢿⠁⠀⠀⢻⡇⠀⢳⡀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣶⣿⣿⣿⣿⡄⠈⡀⢹⣿⣿⣿⣿⣿⣧⣤⢀⠒⠃⠀⢀⠷⠀⠀⣧⠄⠀⢧⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⢀⣤⣾⠟⢋⣭⣴⣶⣶⣶⣶⣤⣄⠃⠸⣿⣿⣿⣿⣿⣿⣿⣿⡏⢀⣤⠎⠀⠀⠀⡇⢠⡆⢸⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⣠⣿⠟⠡⠾⢿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠈⠻⢿⣯⣿⣿⣿⡿⢁⣼⠋⠀⠀⠀⠀⠀⠀⠙⢿⡀⠀⠀⠀⠀⠀",
			"⠀⠀⣴⣿⢃⣾⢸⣿⣾⣿⡿⣋⣭⣍⣛⣩⣭⣉⠻⣆⢠⢁⡙⠋⡉⠀⠀⠘⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠳⡄⠀⠀⠀⠀",
			"⠀⢠⣿⠇⣾⣿⢸⣿⣿⡏⣼⣿⢛⢻⣿⡟⡋⢻⣷⢸⣿⡆⢳⠀⠃⢺⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⡄⠀⠀⠀",
			"⠀⣼⣿⢸⣿⣿⢸⣿⣿⡇⣿⣿⢸⢸⣿⡇⣩⢸⣿⢸⣿⣿⠸⣦⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢳⠀⠀⠀",
			"⠀⣿⣿⢸⣿⣿⢸⣿⢸⡇⣿⣿⢸⢸⣿⡇⣿⢸⣿⢸⣿⣿⢀⣿⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡆⠀⠀",
			"⠀⢸⣿⡌⣿⣿⢸⣿⡌⢷⣭⣭⣼⣬⣭⣥⠟⣸⣿⢰⣿⡟⣸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⠀⠀",
			"⠀⠀⢿⣷⡘⣿⣦⠻⢿⣶⣶⣶⣶⣶⣶⣶⣾⡿⠃⠼⠟⠐⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢧⠀",
			"⠀⠀⠀⢻⣷⣌⠻⣿⣦⣬⣭⣭⡍⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢧",
			"⠀⠀⠀⠀⠙⠿⣷⣬⣙⠻⠿⠔⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈",
		}

		dashboard.section.buttons.val = {
			dashboard.button("f", "󰈞  Find file", "<cmd>Telescope find_files<CR>"),
			dashboard.button("e", "󰈔  New file", "<cmd>ene<BAR>startinsert<CR>"),
			dashboard.button("r", "󰄉  Recently used files", "<cmd>Telescope oldfiles<CR>"),
			dashboard.button("t", "󰱼  Find text", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("c", "󱁤  Configuration", "<cmd>e ~/.config/nvim/init.lua<CR>"),
			dashboard.button("q", "󰗼  Quit Neovim", "<cmd>qa<CR>"),
		}

		dashboard.section.footer.val = "Don't Stop Until You are Proud..."
		dashboard.section.footer.opts.hl = "Type"
		dashboard.section.header.opts.hl = "Include"
		dashboard.section.buttons.opts.hl = "Keyword"
		dashboard.opts.opts.noautocmd = true

		alpha.setup(dashboard.config)

		vim.keymap.set("n", "<leader>ah", function()
			dashboard.section.header.val = headers[math.random(#headers)]
			require("alpha").redraw()
		end, { desc = "Cambiar ASCII de alpha" })
	end,
}
