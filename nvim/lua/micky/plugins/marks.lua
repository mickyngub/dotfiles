local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>mlb", ":MarksListBuf<CR>") -- find string under cursor in current working directory
keymap.set("n", "<leader>mla", ":MarksListAll<CR>") -- find string under cursor in current working directory
