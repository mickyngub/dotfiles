local keymap = vim.keymap

keymap.set("n", "<leader>gl", ":Flog<CR>", { noremap = true })
keymap.set("n", "<leader>glc", ":Floggit Checkout ", { noremap = true })
