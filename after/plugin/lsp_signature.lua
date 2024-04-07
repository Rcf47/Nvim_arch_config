require("lsp_signature").setup({
  floating_window = false
})

vim.keymap.set({ 'n' }, '<leader>vh', function()
  require('lsp_signature').toggle_float_win()
end, { silent = true, noremap = true, desc = 'toggle signature' })

vim.keymap.set({ 'i' }, '<C-h>', function()
  require('lsp_signature').toggle_float_win()
end, { silent = true, noremap = true, desc = 'toggle signature' })
