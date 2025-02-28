--  Found at https://vimcolorschemes.com/i/trending
return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- Load it immediately at startup
    priority = 1000, -- Ensure it loads before other UI-related plugins
    config = function()
      vim.cmd("colorscheme kanagawa")
    end,
  },
}
