-- File Explorer
vim.keymap.set('n', '<leader>e', ':NvimTreeFindFileToggle<CR>')

-- Fuzzy Finding (Telescope)
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>p', function() require('telescope.builtin').find_files() end, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>f', function() require('telescope.builtin').live_grep() end, { desc = 'Find Text' })

-- Commentaries
vim.keymap.set('n', '<leader>/', ':Commentary<CR>', { noremap = false })
vim.keymap.set('v', '<leader>/', ':Commentary<CR>', { noremap = false })

-- Formatting
vim.keymap.set('n', '<leader>l', ':Neoformat<CR>')

-- Documentation & Signatures (The F1 shortcuts)
vim.keymap.set('n', '<F1>', vim.lsp.buf.hover, { desc = 'Show Documentation' })
vim.keymap.set('i', '<F1>', vim.lsp.buf.signature_help, { desc = 'Show Signature Help' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })

-- LSP Navigation & Refactoring
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = 'Go to Definition' })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = 'Go to Implementation' })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = 'Rename Variable' })
vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float(nil, {focus = false}) end, { desc = 'Line Diagnostics' })
