return {
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        view = "cmdline", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
      },
      presets = { command_palette = false }, -- tab completions for commandline don't pop-up at top
    },
  },
}
