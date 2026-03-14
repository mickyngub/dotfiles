local keymap = vim.keymap

keymap.set("n", "<leader>cc", "<cmd>ClaudeCode<CR>", { desc = "Toggle Claude Code" })
keymap.set("n", "<leader>cR", "<cmd>ClaudeCodeResume<CR>", { desc = "Toggle Claude Code Resume" })

keymap.set("i", "<C-,>", "<Plug>(copilot-previous)")
keymap.set("i", "<C-.>", "<Plug>(copilot-next)")
