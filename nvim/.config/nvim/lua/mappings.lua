require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map({ "n", "v" }, ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Normal mode line moving
map("n", "<A-j>", "<CMD>m.+1<CR>==", { desc = "Move current line down" })
map("n", "<A-k>", "<CMD>m.-2<CR>==", { desc = "Move currnent line up" })

-- map("n", "<A-j>", "]e", { desc = "Move current line down" })
-- map("n", "<A-k>", "[e", { desc = "Move currnent line up" })
-- Insert mode line moving
map("i", "<A-j>", "<ESC><CMD>m.+1<CR>==gi", { desc = "Move current line down" })
map("i", "<A-k>", "<ESC><CMD>m.-2<CR>==gi", { desc = "Move current line up" })
-- Visual mode line moving
-- map("v", "<A-j>", "<cmd>'<,'>m'>+1<cr>gv=gv", { desc = "Move current line down" })
-- map("v", "<A-k>", "<cmd>'<,'>m'<-2<cr>gv=gv", { desc = "Move current line up" })

map("v", "<A-k>", "[egv", { desc = "Move selected lines up"})
map("v", "<A-j>", "]egv", { desc = "Move selected lines down"})

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Select all
map("n", "<C-a>", "ggVG", { desc = "Select all in normal mode" })


-- line 1
-- line 2
-- line 3
-- line 4
-- line 5
-- line 6
