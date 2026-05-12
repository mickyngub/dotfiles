local todo_comments_setup, todo_comments = pcall(require, "todo-comments")
if not todo_comments_setup then
	return
end

local keymap = vim.keymap

keymap.set("n", "]t", function()
	todo_comments.jump_next()
end, { desc = "Next todo comment" })
keymap.set("n", "[t", function()
	todo_comments.jump_prev()
end, { desc = "Previous todo comment" })
keymap.set("n", "<leader>td", ":TodoLocList<CR>")

todo_comments.setup({})
