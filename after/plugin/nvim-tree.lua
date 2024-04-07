---- examples for your init.lua

---- disable netrw at the very start of your init.lua (strongly advised)
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1

---- set termguicolors to enable highlight groups
--vim.opt.termguicolors = true

---- empty setup using defaults

---- OR setup with some options
--require("nvim-tree").setup({
-- sort_by = "case_sensitive",
--renderer = {
-- group_empty = true,
--},
--filters = {
-- dotfiles = true,
--},
--update_focused_file = {
-- enable = true,
-- update_root = true,
-- ignore_list = {},
--},
--})
