--[[
-- TODO:
-- - [x] A keymap to help finding files better, ":e /home/jorden/<current folder>"
-- - [x] A word movement like emacs, for alt-f and alt-b
-- - [No] yank, but preserve cursor position, see https://nanotipsforvim.prose.sh/sticky-yank
-- - [x] Duplicate line with cursor position preserved, like vscode <alt-arrowdown>
-- - [ ] Create a opts function here, and use this one on the other files
--]]

local M = {}

M.qf = require('my_scripts.qflist')
-- M.term = require('my_scripts.terminal')
M.term = require('my_scripts.term')
M.subword = require('my_scripts.subword')
M.scratch = require('my_scripts.scratch')

local function find_file()
    if vim.bo.buftype == "terminal" then
        return vim.fn.feedkeys(":e ".. vim.fn.getcwd() .."/")
    else
        return vim.fn.feedkeys(":e ".. vim.fn.expand("%:p:h") .."/")
    end
end


M.setup = function()
    local function opts(description)
        return { desc = description, noremap = true, silent = false }
    end

    -- Set up modules
    M.subword.setup()
    M.scratch.setup()

    -- Quickfix list
    vim.keymap.set("n", "<leader>sc", M.qf.compile_run, opts("Send command to cexpr"))
    vim.keymap.set("n", "<leader>sr", M.qf.compile_rerun, opts("Execute last command sended by send_command"))
    vim.keymap.set("n", "<leader>sf", M.qf.toggle_qf, opts("Toggle quickfix list"))
    vim.keymap.set("n", "<leader>sn", ":cnext<CR>", opts("Quickfix list next error"))
    vim.keymap.set("n", "<leader>sp", ":cprev<CR>", opts("Quickfix list prev error"))

    -- Terminal
    M.term.setup()
    vim.keymap.set("n", "<leader>tn", M.term.open_split, opts("Create new split terminal"))
    -- vim.keymap.set("n", "<leader>t", M.term.toggle_floating_terminal, opts("Toggle floating terminal"))
    -- vim.keymap.set("n", "<leader>t", M.term.toggle_split_terminal, opts("Toggle split terminal"))

    -- Replace all the ^M (you get ^M by typing <ctrl-q><enter> in insert mode)
    vim.keymap.set("n", "<leader>s<CR>", ":%s/\\r//g<CR>", opts("Replace all the ^M"))

    -- Find file (edit file)
    vim.keymap.set("n", "<leader>se", find_file, opts("Find files"))

    -- Emacs like word navigation
    vim.keymap.set({'n', 'i', 'v', 'o'}, "<A-f>", function() return M.subword.process_move('f') end, opts("Subword forward"))
    vim.keymap.set({'n', 'i', 'v', 'o'}, "<A-b>", function() return M.subword.process_move('b') end, opts("Subword backward"))
    vim.keymap.set('i', "<C-a>", "<Home>", opts("Cursor move to line home"))
    vim.keymap.set('i', "<C-e>", "<End>", opts("Cursor move to line end"))

    -- Duplicate line
    vim.keymap.set({'n', 'i'}, "<A-d>", "<cmd>copy .<CR>", opts("Duplicate line"))
end

return M
