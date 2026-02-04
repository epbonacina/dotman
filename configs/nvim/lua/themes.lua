return {
  -- 1. Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- Load this before other plugins
    config = true,    -- Runs require('gruvbox').setup()
  },

  -- 2. Catppuccin (Soft, pastel colors)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },

  -- 3. Tokyo Night (Clean, professional dark blue)
  {
    "folke/tokyonight.nvim",
    priority = 1000,
  },

  -- 4. Kanagawa (Inspired by Japanese paintings)
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
  },
  
  -- 5. Rose Pine (Minimalist, warm)
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
  },
}
