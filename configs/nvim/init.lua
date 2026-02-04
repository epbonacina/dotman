local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- This is the right order
require('core.settings')
require('core.plugins')
require('core.keymaps')

-- vim.cmd.colorscheme("gruvbox")
-- vim.cmd.colorscheme("tokyonight")
vim.cmd.colorscheme("catppuccin")
