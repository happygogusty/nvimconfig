vim.keymap.set('n', '<leader>n', ':NERDTreeFocus<CR>', { desc = 'Focus NERDTree', silent = true })
vim.keymap.set('n', '<C-n>', ':NERDTree<CR>', { desc = 'Open NERDTree', silent = true })
vim.keymap.set('n', '<C-t>', ':NERDTreeToggle<CR>', { desc = 'Toggle NERDTree', silent = true })
vim.keymap.set('n', '<C-f>', ':NERDTreeFind<CR>', { desc = 'Find current file in NERDTree', silent = true })
