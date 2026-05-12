local keymap = vim.keymap

keymap.set("n", "<leader>SS", '<cmd>lua require("spectre").open()<CR>', {
	desc = "Open Spectre",
})
keymap.set("n", "<leader>SW", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
	desc = "Search current word",
})
keymap.set("v", "<leader>SW", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
	desc = "Search current word",
})
keymap.set("n", "<leader>SP", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
	desc = "Search on current file",
})
