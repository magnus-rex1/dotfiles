require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- local M = {}
-- M.dap = {
--   plugin = true,
--   n = {
--     ["<leader>db"] = {
--       "<cmd>DapToggleBreakpoint<CR>",
--       "Add breakpoint at line",
--     },
--     ["<leader>dr"] = {
--       "<cmd>DapContinue<CR>",
--       "Start or continue the debuffer",
--     }
--   }
-- }
--
-- return M
