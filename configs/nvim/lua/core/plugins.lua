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

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- 1. STATE VARIABLE
      -- This tracks if Tab was pressed to "enter" the completion list
      local nav_mode = false

      -- Helper to reset mode when menu closes
      cmp.event:on("menu_closed", function()
        nav_mode = false
      end)

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        -- 2. GHOST TEXT (The "Shadow")
        experimental = {
          ghost_text = true, -- This shows the gray preview inline
        },
        
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },
        snippet = { 
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        
        -- 3. CUSTOM MAPPINGS
        mapping = cmp.mapping.preset.insert({
          
          -- TAB: The "Toggle" Key
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              -- If menu is open, "Enter" the list (Enable Nav Mode)
              nav_mode = true
              cmp.select_next_item() -- Optional: select first item immediately
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          -- DOWN (j)
          ["j"] = cmp.mapping(function(fallback)
            if cmp.visible() and nav_mode then
              cmp.select_next_item()
            else
              fallback() -- If not in "Nav Mode", just type 'j'
            end
          end, { "i", "s" }),

          -- UP (k)
          ["k"] = cmp.mapping(function(fallback)
            if cmp.visible() and nav_mode then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),

          -- CONFIRM (<Leader> / Space)
          ["<Space>"] = cmp.mapping(function(fallback)
            if cmp.visible() and nav_mode then
              cmp.confirm({ select = true })
              nav_mode = false
            else
              fallback() -- Insert a space otherwise
            end
          end, { "i", "s" }),

          -- ESCAPE (Exit list and "keep life going")
          ["<Esc>"] = cmp.mapping(function(fallback)
            if cmp.visible() and nav_mode then
              cmp.close()
              nav_mode = false
              -- Do not fallback() here if you want to stay in Insert Mode.
              -- If you want to go to Normal Mode, add: vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, true, true), 'n', true)
            else
              fallback() -- Default Esc behavior (go to Normal mode)
            end
          end),
        }),

        sources = cmp.config.sources({
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
})
