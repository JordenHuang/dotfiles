-- TODO:
-- 1. Telescope: current buffer fuzzy find

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",


-- opts set in a table to not repeat them everytime
local function opts(description)
    return { desc = description, noremap = true, silent = true }
end


-- leader key is <,>
vim.g.mapleader = ","


-- clear search highlight (<CR> means carriage return)
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", opts("Clear search highlight"))

-- Quick exit INSERT mode
vim.keymap.set("i", "kj", "<Esc>", opts("Exit insert mode"))

-- Move text up and down (<A> means Alt key) vim.keymap.set("n", "<A-j>", ":m +1<CR>==", opts("Move text up"))
vim.keymap.set("n", "<A-j>", ":m +1<CR>==", opts("Move text up"))
vim.keymap.set("n", "<A-k>", ":m -2<CR>==", opts("Move text down"))

-- Shift visual selected lines up and down
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Window easy navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts("Nevigate to left(h) window"))
vim.keymap.set("n", "<C-j>", "<C-w>j", opts("Nevigate to lower(j) window"))
vim.keymap.set("n", "<C-k>", "<C-w>k", opts("Nevigate to upper(k) window"))
vim.keymap.set("n", "<C-l>", "<C-w>l", opts("Nevigate to right(l) window"))

-- Window easy movement
-- Maybe when not using windows terminal, I can set <A-S-h> to <C-S-h> and so on
-- because the ctrl + shift is the windows terminal's keymap,
-- so it doesn't work in neovim
vim.keymap.set("n", "<A-S-h>", "<C-w>H", opts("Move window to the leftmost(H)"))
vim.keymap.set("n", "<A-S-j>", "<C-w>J", opts("Move window to the very bottom(J)"))
vim.keymap.set("n", "<A-S-k>", "<C-w>K", opts("Move window to the very top(K)"))
vim.keymap.set("n", "<A-S-l>", "<C-w>L", opts("Move window to the rightmost(L)"))
vim.keymap.set("n", "<A-S-t>", "<C-w>T", opts("Move window to the new tab"))

-- Shortcut for typing ":w" to save file
vim.keymap.set("n", "<C-s>", ":w<CR>", opts("Save file"))

-- Tabs nevigation
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", opts("Close tab"))

-- Tab and Shift-Tab indent and unindent
-- vim.keymap.set("n", "<leader><Tab>", ">>", opts("Indent, normal mode"))
-- vim.keymap.set("n", "<leader><S-Tab>", "<<", opts("Unindent, normal mode"))
vim.keymap.set("v", "<Tab>", ">", opts("Indent, visual mode"))
vim.keymap.set("v", "<S-Tab>", "<", opts("Unindent, visual mode"))


