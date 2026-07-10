vim.cmd("let mapleader = ' '")

-------------------------------------------------
-- FILE EXPLORER (Neo-tree)
-------------------------------------------------
vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left toggle<CR>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>e", ":Neotree focus<CR>", { desc = "Focus file explorer" })

-------------------------------------------------
-- TELESCOPE
-------------------------------------------------
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fw", ":Telescope live_grep<CR>", { desc = "Find text (live grep)" })
vim.keymap.set("n", "<leader>of", ":Telescope oldfiles<CR>", { desc = "Recent files" })
vim.keymap.set("n", "<leader>fc", ":Telescope colorscheme<CR>", { desc = "Change colorscheme" })
vim.keymap.set("n", "<leader>lp", ":Telescope lsp_document_symbols<CR>", { desc = "LSP document symbols" })

-------------------------------------------------
-- BUFFERS (Barbar)
-------------------------------------------------
vim.keymap.set("n", "<tab>", ":BufferNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-tab>", ":BufferPrevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>x", ":BufferClose<CR>", { desc = "Close buffer" })

-------------------------------------------------
-- COMMENTS
-------------------------------------------------
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment" })

-------------------------------------------------
-- TOGGLETERM
-------------------------------------------------
vim.keymap.set("n", "<leader>tr", ":ToggleTerm<CR>", { desc = "Toggle terminal (default)" })
vim.keymap.set("n", "<leader>ts", ":ToggleTerm direction=horizontal<CR>", { desc = "Terminal horizontal" })
vim.keymap.set("n", "<leader>tv", ":ToggleTerm direction=vertical size=80<CR>", { desc = "Terminal vertical" })
vim.keymap.set("n", "<leader>tf", ":ToggleTerm direction=float<CR>", { desc = "Terminal flotante" })

-- Terminales numeradas (independientes entre sí)
vim.keymap.set("n", "<leader>t1", ":1ToggleTerm<CR>", { desc = "Terminal 1" })
vim.keymap.set("n", "<leader>t2", ":2ToggleTerm<CR>", { desc = "Terminal 2" })
vim.keymap.set("n", "<leader>t3", ":3ToggleTerm<CR>", { desc = "Terminal 3" })

-- Keymaps dentro del modo terminal
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
