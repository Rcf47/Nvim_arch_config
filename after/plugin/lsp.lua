local lsp = require("lsp-zero")
lsp.extend_lspconfig()
require("lspconfig").intelephense.setup({})
require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = { "ts_ls" },
  handlers = {
    lsp.default_setup,
  },
})
lsp.preset("recommended")
local lspconfig = require("lspconfig")
lspconfig.ts_ls.setup({
  init_options = {
    preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
      importModuleSpecifierPreference = "non-relative",
    },
  },
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
  ["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
  ["<CR>"] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
  ["<C-c>"] = cmp.mapping.close(),
})

lsp.set_preferences({
  sign_icons = {},
})

cmp.setup({
  mapping = cmp_mappings,
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "luasnip" },
    { name = "nvim_lua" },
  },
})

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local enable_format_on_save = function(_, bufnr)
  vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup_format,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({ bufnr = bufnr })
    end,
  })
end

lsp.on_attach(function(client, bufnr)
  local optsFunc = function(description)
    return { desc = description, buffer = bufnr, remap = false }
  end
  enable_format_on_save(client, bufnr)
  vim.keymap.set("n", "<F2>", function()
    vim.lsp.buf.rename()
  end, optsFunc("Rename"))
  vim.keymap.set("n", "gr", function()
    vim.lsp.buf.references()
  end, optsFunc("Go references"))
  vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
  end, optsFunc("Go definition"))
  vim.keymap.set("n", "tgd", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", optsFunc("Go definition"))
  vim.keymap.set("n", "<leader>vk", function()
    vim.lsp.buf.hover()
  end, optsFunc("Hover code"))
  vim.keymap.set("n", "<leader>vws", function()
    vim.lsp.buf.workspace_symbol()
  end, optsFunc("Workspace Symbol"))
  vim.keymap.set("n", "<leader>vd", function()
    vim.diagnostic.open_float()
  end, optsFunc("Diagnostic"))
  vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_next()
  end, optsFunc("Go to next"))
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_prev()
  end, optsFunc("Go to prev"))
  vim.keymap.set("n", "<leader>vca", function()
    vim.lsp.buf.code_action()
  end, optsFunc("Code action"))
  vim.keymap.set("n", "<leader>vrn", function()
    vim.lsp.buf.rename()
  end, optsFunc("Rename"))
  vim.keymap.set("i", "<C-h>", function()
    vim.lsp.buf.signature_help()
  end, optsFunc("Signature help"))
  vim.keymap.set("n", "<F3>", function()
    vim.lsp.buf.format()
  end, optsFunc("Format"))
end)

vim.diagnostic.config({
  virtual_text = true,
  globals = { "vim" },
})
lsp.setup()
