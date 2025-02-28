-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "v", "o" }, ";", ":", { noremap = true, desc = "Swap ; with :" })
vim.keymap.set({ "n", "v", "o" }, ":", ";", { noremap = true, desc = "Swap : with ;" })

vim.keymap.set("n", "<leader>ww", ":set wrap!<CR>", { desc = "Toggle Word Wrap" })
