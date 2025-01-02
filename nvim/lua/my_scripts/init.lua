local M = {}

M.qf = require('my_scripts.qflist')
M.term = require('my_scripts.terminal')

-- Set background
M.set_background = function()
    if vim.o.background == "light" then
        vim.cmd "set background=dark"
    elseif vim.o.background == "dark" then
        vim.cmd "set background=light"
    end
    vim.cmd "2 sleep"
end



-- Although it's called setup function, actually it only adds some keymaps :P
M.setup = function()
    -- keymaps start with <leader>s, s means self, as this is my personal create functions
    local function opts(description)
        return { desc = description, noremap = true, silent = false }
    end

    vim.keymap.set("n", "<leader>sc", M.qf.send_command, opts("Send command to cexpr"))
    vim.keymap.set("n", "<leader>sr", M.qf.exec_last_command, opts("Execute last command sended by send_command"))
    vim.keymap.set("n", "<leader>sf", M.qf.toggle_qf, opts("Toggle quickfix list"))
    -- TODO: add cnext, cprev keybind
    vim.keymap.set("n", "<leader>sn", "<Cmd>cnext<CR>", opts("Toggle quickfix list"))
    vim.keymap.set("n", "<leader>sp", "<Cmd>cprev<CR>", opts("Toggle quickfix list"))

    vim.keymap.set("n", "<leader>sb", M.set_background, opts("Set background"))

    vim.keymap.set("n", "<leader>st", M.term.toggle_floating_terminal, opts("Toggle floating terminal"))
end

return M
