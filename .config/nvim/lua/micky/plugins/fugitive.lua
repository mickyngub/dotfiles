local keymap = vim.keymap

keymap.set("n", "<leader>gs", ":Git<CR>")
keymap.set("n", "<leader>g", ":Git ", { noremap = true })
keymap.set("n", "<leader>gc", ":Git checkout ", { noremap = true })
keymap.set("n", "<leader>gB", ":Git bisect ", { noremap = true })
keymap.set("n", "<leader>gp", ":Git pull ", { noremap = true })
keymap.set("n", "<leader>gP", ":Git push ", { noremap = true })
