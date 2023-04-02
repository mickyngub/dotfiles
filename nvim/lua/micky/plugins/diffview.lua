local keymap = vim.keymap

keymap.set("n", "<leader>dv", ":DiffviewOpen ", { noremap = true })
keymap.set("n", "<leader>dvo", ":DiffviewOpen<CR>", { noremap = true })
keymap.set("n", "<leader>dvc", ":DiffviewClose<CR>", { noremap = true })
