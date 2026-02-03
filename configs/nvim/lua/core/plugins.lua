require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- the package manager
  use 'nvim-tree/nvim-tree.lua' -- file explorer
  use 'nvim-treesitter/nvim-treesitter' -- syntax highlighting
  use 'tpope/vim-commentary' -- helps commenting stuff out
  use 'neovim/nvim-lspconfig'
  use 'sbdchd/neoformat'
  use 'hrsh7th/nvim-cmp' -- autocompletion
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for `nvim-cmp`
  use 'L3MON4D3/LuaSnip' -- snippets plugin
  use 'saadparwaiz1/cmp_luasnip' -- snippets source for `nvim-cmp`
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
end)

-- nvim-tree configuration
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup()
vim.keymap.set('n', '<leader>e', ':NvimTreeFindFileToggle<CR>')


-- nvim-treesitter configuration
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', builtin.find_files, {})


-- nvim-lspconfig configuration
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local lspconfig = require("lspconfig")

local lang_servers = { "pyright", "clangd", "rust_analyzer", "tsserver"}
for _, lang_server in ipairs(lang_servers) do
	lspconfig[lang_server].setup({
		capabilities = capabilities,
        on_attach = function(client, buffno)
            local map_opts = { noremap=true, silent=true, buffer=buffno  }
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

local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
	},
})


-- nvim-telescope configuration
require'nvim-treesitter.configs'.setup {
  ensure_installed = {'c', 'cpp', 'lua', 'rust', 'vim', 'python', 'javascript'},
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
}
