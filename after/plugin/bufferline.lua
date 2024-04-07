local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

bufferline.setup({
  options = {
    mode = "tabs",
    numbers = "ordinal",
    separator_style = { '', '' },
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true,
  },
  highlights = {
    separator = {
      fg = '#332E41',
      bg = '#070003',
    },
    separator_selected = {
      fg = '#1E1E28',
    },
    background = {
      fg = '#A4B9EF',
      bg = '#332E41'
    },
    buffer_selected = {
      fg = '#F2CECF',
      bold = true,
    },
    fill = {
      bg = '#332E41'
    }
  },
})

vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})

vim.keymap.set('n', '<leader>1', '1gt', { desc = "tab 1" })
vim.keymap.set('n', '<leader>2', '2gt', { desc = "tab 2" })
vim.keymap.set('n', '<leader>3', '3gt', { desc = "tab 3" })
vim.keymap.set('n', '<leader>4', '4gt', { desc = "tab 4" })
vim.keymap.set('n', '<leader>5', '5gt', { desc = "tab 5" })
vim.keymap.set('n', '<leader>6', '6gt', { desc = "tab 6" })
vim.keymap.set('n', '<leader>7', '7gt', { desc = "tab 7" })
vim.keymap.set('n', '<leader>8', '8gt', { desc = "tab 8" })
vim.keymap.set('n', '<leader>9', '<Cmd>tablast<CR>', { desc = "tablast" })
vim.keymap.set('n', '<leader>0', '<Cmd>tabs<CR>', { desc = "tablist" })
