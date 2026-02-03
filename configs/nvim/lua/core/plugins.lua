require("lazy").setup({
  "folke/lazy.nvim",

  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require("nvim-tree").setup()
      vim.keymap.set('n', '<leader>e', ':NvimTreeFindFileToggle<CR>')
    end
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter').setup {
        ensure_installed = {'c', 'cpp', 'lua', 'rust', 'vim', 'python', 'javascript'},
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
      }
    end
  },

  "tpope/vim-commentary",
  "sbdchd/neoformat",

  {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<C-p>', builtin.find_files, {})
    end
  },

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
      
      local lang_servers = { "pyright", "clangd", "rust_analyzer", "ts_ls" }

      for _, lang_server in ipairs(lang_servers) do
        vim.lsp.config(lang_server, {
          capabilities = capabilities,
          on_attach = function(client, buffno)
            local map_opts = { noremap=true, silent=true, buffer=buffno }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, map_opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, map_opts)
            vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, map_opts)
            vim.keymap.set("n", "gn", vim.diagnostic.goto_next, map_opts)
            vim.keymap.set("n", "gp", vim.diagnostic.goto_prev, map_opts)
            vim.keymap.set("n", "ga", vim.lsp.buf.code_action, map_opts)
            vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, map_opts)
            vim.keymap.set("n", "<F1>", vim.lsp.buf.hover, map_opts)
            vim.keymap.set("i", "<F1>", vim.lsp.buf.signature_help, map_opts)
            vim.keymap.set("n", "<leader>d", ":lua vim.diagnostic.open_float(nil, {focus = false})<CR>", map_opts)
          end
        })
      end

      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
          ["<Tab>"] = function(fallback)
            if cmp.visible() then cmp.select_next_item() else fallback() end
          end,
          ["<S-Tab>"] = function(fallback)
            if cmp.visible() then cmp.select_prev_item() else fallback() end
          end,
        }),
        sources = { { name = "nvim_lsp" } },
      })
    end
  },
})