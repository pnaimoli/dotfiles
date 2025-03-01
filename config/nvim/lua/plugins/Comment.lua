return {
  "numToStr/Comment.nvim",
  event = { "CursorMoved" },
  opts = {
    -- add any options here
  },
  config = function()
    require("Comment").setup()
  end,
}
