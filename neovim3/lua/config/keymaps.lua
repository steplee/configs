-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local map = vim.keymap.set

map("i", "jk", "<Esc>")

-- alt+i opens/closes terminal.
map({ "n", "i" }, "<A-i>", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (root)" })
map({ "t" }, "<A-i>", "<cmd>close<cr>", { desc = "Terminal (root)" })

map({ "n" }, "<leader>uz", function() Snacks.zen({win={minimal=false, width=200, backdrop = {transparent=false}, keys={q="close"}}}) end, { desc = "Zen" })
map({ "n", "x" }, "C", "gcc", { desc = "Toggle Comment Line", remap=true })
