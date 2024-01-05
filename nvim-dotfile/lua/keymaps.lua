
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",


-- opts set in a table to not repeat them everytime
local opts = { noremap = true, silent = true }


-- leader key is <;>
vim.g.mapleader = ";"


-- clear search highlight (<CR> means carriage return)
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", opts)


-- Move text up and down (<A> means Alt key)
vim.keymap.set("n", "<A-j>", ":m +1<CR>==")
vim.keymap.set("n", "<A-k>", ":m -2<CR>==")


-- Nvim-tree keymap
--local api = require("nvim-tree.api")
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")



--[[  maybe use leader key instead of Alt key?
To use `ALT+{h,j,k,l}` to navigate windows from any mode: >
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
--]]
