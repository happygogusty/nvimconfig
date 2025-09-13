vim.keymap.set('n', '<leader>t', ':NERDTreeFocus<CR>', { desc = 'Focus NERDTree', silent = true })
vim.keymap.set('n', '<C-n>', ':NERDTree<CR>', { desc = 'Open NERDTree', silent = true })
vim.keymap.set('n', '<C-t>', ':NERDTreeToggle<CR>', { desc = 'Toggle NERDTree', silent = true })
vim.keymap.set('n', '<C-f>', ':NERDTreeFind<CR>', { desc = 'Find current file in NERDTree', silent = true })


vim.api.nvim_create_augroup("PythonRunner", { clear = true })

vim.api.nvim_create_autocmd("Filetype", {
  pattern = "python",
  group = "PythonRunner",
  callback = function()
    vim.keymap.set("n", "<leader>q", function()
      vim.cmd("write")

      vim.cmd("vert terminal clear && python3 " .. vim.fn.expand("%:p"))
    end, { buffer = true, silent = true, desc = "Run Python Script" })
  end,
})
