require("lazy").setup({
  "folke/lazy.nvim",

  -- Icons and Visuals
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require("nvim-tree").setup()
    end
  },

  -- Syntax Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter').setup({
        ensure_installed = {'c', 'cpp', 'lua', 'rust', 'vim', 'python', 'javascript'},
        auto_install = true,
        highlight = { enable = true },
      })
    end
  },

  "tpope/vim-commentary",
  "sbdchd/neoformat",

  -- Fuzzy Finder
  {
    "nvim-telescope/telescope.nvim",
    branch = 'master', -- Fixed: Use master for Neovim 0.11+ compatibility
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({
        defaults = {
          -- Optional: If master still shows errors, uncomment the line below
          -- preview = { treesitter = false }, 
        }
      })
    end
  },

  -- LSP and Autocompletion
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",         
      "hrsh7th/cmp-nvim-lsp",     
      "L3MON4D3/LuaSnip",         
      "saadparwaiz1/cmp_luasnip", 
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local servers = { "pyright", "clangd", "rust_analyzer", "ts_ls" }
      
      for _, server in ipairs(servers) do
        vim.lsp.config(server, { capabilities = capabilities })
      end

      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        sources = { { name = "nvim_lsp" } },
      })
    end
  },
})
