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

-- Move text up and down (<A> means Alt key)
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


-- Nvim-tree keymap
--local api = require("nvim-tree.api")
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts("Open nvim-tree"))



-- Nvim-telescope keymap
vim.keymap.set('n', '<leader>ff', ":Telescope find_files<CR>", opts("Telescope find file"))
vim.keymap.set('n', '<leader>fb', ":Telescope buffers initial_mode=normal<CR>", opts("Telescope buffers"))
vim.keymap.set('n', '<leader>fl', ":Telescope live_grep<CR>", opts("Telescope live grep"))
vim.keymap.set('n', '<leader>fh', ":Telescope help_tags<CR>", opts("Telescope help tags"))
vim.keymap.set('n', '<leader>fk', ":Telescope keymaps initial_mode=normal<CR>", opts("Telescope show keymaps"))
vim.keymap.set('n', '<leader>fm', ":Telescope marks initial_mode=normal<CR>", opts("Telescope show marks"))
vim.keymap.set('n', '<leader>fo', ":Telescope oldfiles initial_mode=normal<CR>", opts("Telescope show old files"))



-- open file_browser with the path of the current buffer
vim.keymap.set("n", "<leader>oo", ":Oil .<CR>", opts("Open oil file browser"))
vim.keymap.set("n", "<leader>od", ":lua require('oil').discard_all_changes()<CR>", opts("Oil discard all changes"))



-- Nvim-toggleterm keymap
vim.keymap.set("n", "<leader>th",  ":ToggleTerm size=12 direction=horizontal name=terminal<CR>", opts("Toggleterm open horizontal"))
vim.keymap.set("n", "<leader>tv",  ":ToggleTerm size=60 direction=vertical name=terminal<CR>",   opts("Toggleterm open vertical"))
vim.keymap.set("n", "<leader>tf",  ":ToggleTerm size=20 direction=float name=terminal<CR>",      opts("Toggleterm open float"))
-- vim.keymap.set("n", "<leader>tn",  ":TermExec cmd='echo %' size=12 direction=horizontal name=terminal<CR>", opts("Toggletrem open second terminal horizontally"))
function _G.set_terminal_keymaps()
    local function opts(desc)
        return {desc = "Toggleterm: "..desc, buffer = 0}
    end

    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts("leave terminal mode"))
    vim.keymap.set("t", "kj", "<C-\\><C-n>",    opts("leave terminal mode"))
    vim.keymap.set("t", "<leader>w", "<C-\\><C-n><C-w><C-w>",    opts("navigation of windows"))
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')


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
