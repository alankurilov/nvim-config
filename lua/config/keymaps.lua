-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- local map = vim.keymap.set

local map = vim.keymap.set

-- Удаление без записи в буфер
map("n", "x", '"_x', { desc = "Delete character without yanking" })
map("n", "d", '"_d', { desc = "Delete without yanking" })
map("v", "d", '"_d', { desc = "Visual delete without yanking" })

-- Можно также переназначить 'c' (change), если хочешь:
map("n", "c", '"_c', { desc = "Change without yanking" })
map("v", "c", '"_c', { desc = "Visual change without yanking" })
