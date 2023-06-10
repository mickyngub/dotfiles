local keymap = vim.keymap

keymap.set("n", "<leader>gs", ":Git<CR>")
keymap.set("n", "<leader>gg", ":Git ", { noremap = true })
keymap.set("n", "<leader>ggc", ":Git checkout ", { noremap = true })
keymap.set("n", "<leader>ggb", ":Git bisect ", { noremap = true })
keymap.set("n", "<leader>ggp", ":Git pull ", { noremap = true })
keymap.set("n", "<leader>ggP", ":Git push ", { noremap = true })
