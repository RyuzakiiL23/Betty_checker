-- set leader key to space
vim.g.mapleader = " "

vim.api.nvim_set_keymap(
	"n",
	"<leader>be",
	':lua require("betty_checker").check_betty_errors()<CR>',
	{ noremap = true, silent = true }
)
