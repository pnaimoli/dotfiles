-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","
vim.g.maplocalleader = "," -- If you want the local leader key to also be ','
vim.o.autochdir = true --  switch to the directory of whatever your active buffer
vim.o.relativenumber = false
vim.o.ignorecase = true -- Ignore case when searching
vim.o.smartcase = true -- Override ignorecase if search includes uppercase
vim.o.title = true -- Update terminal window title to show the current file
vim.o.showbreak = ">>" -- Mark wrapped lines
vim.o.undofile = false -- Don't automatically save undo history
