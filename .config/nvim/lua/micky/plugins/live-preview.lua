local keymap = vim.keymap

keymap.set("n", "<leader>htp", ":LivePreview start<CR>", { desc = "live html preview" })
keymap.set("n", "<leader>hts", ":LivePreview close<CR>", { desc = "stop html preview" })
