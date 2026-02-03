vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- commentaries (based on the `tpope/vim-commentary` plugin)
vim.keymap.set('n', '<C-/>', ':Commentary<CR>', {noremap = false})
vim.keymap.set('i', '<C-/>', '<ESC>:Commentary<CR>', {noremap = false})
vim.keymap.set('v', '<C-/>', ':Commentary<CR>', {noremap = false})

-- formatting
vim.keymap.set('n', '<leader>f', ':Neoformat<CR>')
