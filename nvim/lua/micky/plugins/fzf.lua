local keymap = vim.keymap

keymap.set("t", "<leader><leader>", "<C-g>")

keymap.set("n", "<leader>bf", ":Buffers<CR>", { noremap = true })
keymap.set("n", "<leader>bh", ":History<CR>", { noremap = true })
keymap.set("n", "<leader>bj", ":Jumps<CR>", { noremap = true })
keymap.set("n", "<leader>bb", ":b#<CR>", { noremap = true })
keymap.set("n", "<leader>bc", ":History:<CR>", { noremap = true })
