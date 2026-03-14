local keymap = vim.keymap

vim.cmd([[
com -nargs=1 -complete=command Redir
      \ :execute "vsplit | pu=execute(\'" . <q-args> . "\') | setl nomodified"
]])

keymap.set("t", "<leader><leader>", "<C-g>")

vim.cmd([[
    command! -bang -nargs=* -complete=dir Buffers
        \ call fzf#vim#buffers(<q-args>, fzf#vim#with_preview({
        \   'options': ['--delimiter', '/', '--with-nth', '-4..']
        \ }), <bang>0)
]])

-- Then create the mapping
keymap.set("n", "<leader>bf", ":Buffers<CR>", { noremap = true })

keymap.set("n", "<leader>bh", ":History<CR>", { noremap = true })
keymap.set("n", "<leader>bj", ":Jumps<CR>", { noremap = true })
keymap.set("n", "<leader>bb", ":b#<CR>", { noremap = true })
keymap.set("n", "<leader>bc", ":History:<CR>", { noremap = true })
