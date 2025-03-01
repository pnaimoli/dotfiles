-- huh
return {
  "Vonr/align.nvim",
  branch = "v2",
  event = { "CursorMoved" },
  init = function()
    -- Create your mappings here
    local NS = { noremap = true, silent = true }

    -- Aligns to a Vim regex with previews
    vim.keymap.set("x", "A", function()
      require("align").align_to_string({
        preview = true,
        regex = true,
      })
    end, NS)
  end,
}
