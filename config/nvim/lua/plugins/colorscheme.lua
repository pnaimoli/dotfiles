--  Found at https://vimcolorschemes.com/i/trending
return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- Load it immediately at startup
    priority = 1000, -- Ensure it loads before other UI-related plugins
  },
}
