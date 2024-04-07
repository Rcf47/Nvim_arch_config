require 'nvim-jest'.setup {
  -- Jest executable
  -- By default finds jest in the relative project directory
  -- To override with an npm script, provide 'npm test --' or similar

  -- Prevents tests from printing messages
  silent = true,
}

vim.keymap.set('n', '<leader>jj', '<cmd>Jest<CR>', { desc = 'Jest' })
vim.keymap.set('n', '<leader>jc', '<cmd>bd term<tab><CR>', { desc = 'Jest close' })
vim.keymap.set('n', '<leader>jf', '<cmd>JestFile<CR>', { desc = 'JestFile' })
vim.keymap.set('n', '<leader>js', '<cmd>JestSingle<CR>', { desc = 'JestSingle' })
vim.keymap.set('n', '<leader>jco', '<cmd>JestCoverage<CR>', { desc = 'JestCoverage' })
