local wk = require("which-key")

require("which-key").setup({
  icons = {
    mappings = false,
  },
})
wk.add({
  { "<leader><leader>", group = "Highlight color and others", icon = { icon = "", color = "red" } },
  { "<leader><leader>d", group = "Vim diagnostic" },
  { "<leader>a", group = "Autosave toggle" },
  { "<leader>d", group = "Diffview and dapUI" },
  { "<leader>e", group = "Numeric line" },
  { "<leader>g", group = "Fugitive git" },
  { "<leader>h", group = "Gitsigns" },
  { "<leader>i", group = "Indent-blankline" },
  { "<leader>j", group = "Jest" },
  { "<leader>l", group = "Lazygit" },
  { "<leader>m", group = "Harpoon" },
  { "<leader>n", group = "NvimTree" },
  { "<leader>q", group = "My macros" },
  { "<leader>s", group = "Split window" },
  { "<leader>t", group = "Telescope" },
  { "<leader>v", group = "LSP and Others" },
  { "<leader>vc", group = "Code action" },
  { "<leader>vp", group = "Open packer" },
  { "<leader>vr", group = "Reference and rename" },
  { "<leader>vw", group = "Workspace Symbol" },
})
