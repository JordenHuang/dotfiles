--[[
-- TODO:
-- - [x] A keymap to help finding files better, ":e /home/jorden/<current folder>"
-- - [x] A word movement like emacs, for alt-f and alt-b
-- - [No] yank, but preserve cursor position, see https://nanotipsforvim.prose.sh/sticky-yank
-- - [x] Duplicate line with cursor position preserved, like vscode <alt-arrowdown>
--]]

local M = {}

M.qf = require('my_scripts.qflist')
M.term = require('my_scripts.terminal')
M.subword = require('my_scripts.subword')

-- Set background
M.set_background = function()
    if vim.o.background == "light" then
        vim.cmd "set background=dark"
    elseif vim.o.background == "dark" then
        vim.cmd "set background=light"
    end
    vim.cmd "2 sleep"
end

local function dup_line()
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd('normal! Yp')
    vim.api.nvim_win_set_cursor(0, {cursor[1]+1, cursor[2]})
end


-- Although it's called setup function, actually it only adds some keymaps :P
M.setup = function()
    -- keymaps start with <leader>s, s means self, as this is my personal create functions
    local function opts(description)
        return { desc = description, noremap = true, silent = false }
    end

    -- Set up modules
    M.subword.setup()

    vim.keymap.set("n", "<leader>sc", M.qf.send_command, opts("Send command to cexpr"))
    vim.keymap.set("n", "<leader>sr", M.qf.exec_last_command, opts("Execute last command sended by send_command"))
    vim.keymap.set("n", "<leader>sf", M.qf.toggle_qf, opts("Toggle quickfix list"))
    vim.keymap.set("n", "<leader>sn", ":cnext<CR>", opts("Toggle quickfix list"))
    vim.keymap.set("n", "<leader>sp", ":cprev<CR>", opts("Toggle quickfix list"))

    vim.keymap.set("n", "<leader>sb", M.set_background, opts("Set background"))

    vim.keymap.set("n", "<leader>st", M.term.toggle_floating_terminal, opts("Toggle floating terminal"))

    -- Replace all the ^M (try to type <ctrl-q> + <enter>)
    vim.keymap.set("n", "<leader>sr", ":%s/\\r//g<CR>", opts("Replace all the ^M"))

    vim.keymap.set("n", "<leader>se", ":e "..vim.uv.cwd(), opts("Find files"))

    -- Emacs like word navigation
    vim.keymap.set({'n', 'v', 'o'}, "<A-f>", function() return M.subword.process_move('f') end, opts("Subword forward"))
    vim.keymap.set({'n', 'v', 'o'}, "<A-b>", function() return M.subword.process_move('b') end, opts("Subword backward"))

    -- Duplicate line
    vim.keymap.set({'n', 'i'}, "<A-d>", dup_line, opts("Duplicate line"))
end

return M
