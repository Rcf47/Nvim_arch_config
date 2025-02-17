-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  use("akinsho/nvim-bufferline.lua")

  use("nvim-lualine/lualine.nvim") -- Statusline

  use({
    --keyboard layout
    "yorik1984/lualine-xkblayout",
    requires = {
      "nvim-lualine/lualine.nvim",
      "lyokha/vim-xkbswitch",
    },
  })

  use("kyazdani42/nvim-web-devicons") -- File icons

  use({
    "nvim-telescope/telescope.nvim",
    -- or                            , branch = '0.1.x',
    requires = { { "nvim-lua/plenary.nvim" }, { "nvim-telescope/telescope-live-grep-args.nvim" } },
  })

  use("nvim-telescope/telescope-file-browser.nvim")
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use("xiyaowong/telescope-emoji.nvim")

  use("windwp/nvim-autopairs")
  use("windwp/nvim-ts-autotag")

  use({ "catppuccin/nvim", as = "catppuccin" })
  use({ "hardhackerlabs/theme-vim", as = "hardhacker" })
  use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
  --use("ThePrimeagen/harpoon")
  use("mbbill/undotree")
  use("tpope/vim-fugitive")
  use({
    "VonHeikemen/lsp-zero.nvim",
    requires = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },             -- Required
      { "williamboman/mason.nvim" },           -- Optional
      { "williamboman/mason-lspconfig.nvim" }, -- Optional

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },         -- Required
      { "hrsh7th/cmp-nvim-lsp" },     -- Required
      { "hrsh7th/cmp-buffer" },       -- Optional
      { "hrsh7th/cmp-path" },         -- Optional
      { "saadparwaiz1/cmp_luasnip" }, -- Optional
      { "hrsh7th/cmp-nvim-lua" },     -- Optional

      -- Snippets
      { "L3MON4D3/LuaSnip" },             -- Required
      { "rafamadriz/friendly-snippets" }, -- Optional
    },
  })
  use("williamboman/mason.nvim")

  use("lukas-reineke/lsp-format.nvim")
  --use("tpope/vim-surround")
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
  })

  --Debug adapter protocol
  use("mfussenegger/nvim-dap")
  use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } })
  use("folke/neodev.nvim") --for dap-ui
  use({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } })
  use({
    "microsoft/vscode-js-debug",
    opt = true,
    run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
  })
  use("chrisbra/Colorizer")
  --diffview
  use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

  --gitsigns
  use({
    "lewis6991/gitsigns.nvim",
    -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
  })
  use("kdheepak/lazygit.nvim")
  --  use { "akinsho/toggleterm.nvim", tag = '*', config = function()
  --    require("toggleterm").setup()
  --  end }

  --Which key
  use({
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  })

  --Pathogen for telescope navigation
  use("brookhong/telescope-pathogen.nvim")

  --emmet
  use("mattn/emmet-vim")

  --file browser
  --  use 'nvim-tree/nvim-tree.lua'

  --auto-session
  --use 'nyngwang/suave.lua'
  use("natecraddock/sessions.nvim")

  --nvim-comment
  use("terrortylor/nvim-comment")

  --jest.nvim
  use("mattkubej/jest.nvim")

  --delay repeat execution
  --use("ja-ford/delaytrain.nvim")

  --leap motion plugin
  use("ggandor/leap.nvim")

  --mark plugin
  use("chentoast/marks.nvim")

  --oil for file system
  use("stevearc/oil.nvim")

  --indent plugin
  use("lukas-reineke/indent-blankline.nvim")

  --spliting/joining blocks
  use({ "Wansmer/treesj", requires = { "nvim-treesitter" } })

  --autosave
  --use 'Pocco81/auto-save.nvim'

  --signature help with func
  use("ray-x/lsp_signature.nvim")

  --formmater for prettier autosave
  -- use "mhartington/formatter.nvim"
  --for new prettier
  use("neovim/nvim-lspconfig")
  use("jose-elias-alvarez/null-ls.nvim")
  use("MunifTanjim/prettier.nvim")

  --markdown-preview install without yarn or npm
  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  })

  --render-makrdown
  use({
    "MeanderingProgrammer/render-markdown.nvim",
    after = { "nvim-treesitter" },
    --requires = { 'echasnovski/mini.nvim', opt = true }, -- if you use the mini.nvim suite
    -- requires = { 'echasnovski/mini.icons', opt = true }, -- if you use standalone mini plugins
    requires = { "nvim-tree/nvim-web-devicons", opt = true }, -- if you prefer nvim-web-devicons
    config = function()
      require("render-markdown").setup({})
    end,
  })

  --confrom for autoformat
  use("stevearc/conform.nvim")

  --nvim-lint for linters
  use("mfussenegger/nvim-lint")
  --typescript tools for faster work
  --use {
  -- "pmizio/typescript-tools.nvim",
  --requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --config = function()
  -- require("typescript-tools").setup {}
  --end,
  --}

  --codeium
  use({
    "Exafunction/codeium.vim",
    requires = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    commit = "289eb724e5d6fab2263e94a1ad6e54afebefafb2",
  })

  --better quickfix
  use({ "kevinhwang91/nvim-bqf" })

  --trouble
  use({ "folke/trouble.nvim" })

  --mini ai for better dif
  use({ "echasnovski/mini.ai" })

  -- for java lsp
  use("mfussenegger/nvim-jdtls")

  -- colorscheme Tokyo night
  use({ "folke/tokyonight.nvim" })

  --Neotree file browser
  -- use({
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v3.x",
  --   requires = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --     "MunifTanjim/nui.nvim",
  --     "3rd/image.nvim",              -- Optional image support in preview window: See `# Preview Mode` for more information
  --   },
  -- })

  -- telescope tabs
  use({ "LukasPietzschmann/telescope-tabs", requires = { "nvim-telescope/telescope.nvim" } })

  --for telescope layout nui.nvim
  use({ "MunifTanjim/nui.nvim" })
end)
