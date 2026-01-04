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


 -- alt h/j/k/l navigates windows.
vim.cmd([[
:tnoremap <A-h> <C-\><C-N><C-w>h
:tnoremap <A-j> <C-\><C-N><C-w>j
:tnoremap <A-k> <C-\><C-N><C-w>k
:tnoremap <A-l> <C-\><C-N><C-w>l
:inoremap <A-h> <C-\><C-N><C-w>h
:inoremap <A-j> <C-\><C-N><C-w>j
:inoremap <A-k> <C-\><C-N><C-w>k
:inoremap <A-l> <C-\><C-N><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l
]])
