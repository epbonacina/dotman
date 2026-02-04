require("lazy").setup({
  { import = "themes" }, -- Imports my themes at 'themes.lua'

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
    lazy = false, 
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter').install({ 
        "python", "rust", "lua", "javascript", "bash", "c", "cpp" 
      })
  
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end
  },

  "tpope/vim-commentary",
  "sbdchd/neoformat",

  -- Fuzzy Finder
  {
    "nvim-telescope/telescope.nvim",
    branch = 'master',
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
    config = function()
      local servers = {"pyright", "rust_analyzer", "clangd", "ts_ls"}
      for _, server in ipairs(servers) do
        vim.lsp.enable(server)
      end
    end
  },
})
