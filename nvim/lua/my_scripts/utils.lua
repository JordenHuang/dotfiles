-- TODO: make a plugin that contains some useful
-- quickfix list utils

local M = {}

--===== Quickfix list =====
M.qf_open = false
M.last_command = ''

M.send_command = function()
    vim.ui.input(
        { prompt = "Command: ", default = M.last_command, completion = "file"},
        function(cmd)
            if cmd == nil or cmd == '' then
                print("Empty input, abort")
                return
            end

            M.last_command = cmd
            local command = "cexpr system('" .. cmd .. "')"
            vim.cmd(command)

            -- Open quickfix window
            if not M.qf_open then
                vim.cmd("copen")
                M.qf_open = true
            end
        end
    )
end

M.exec_last_command = function()
    if M.last_command == '' then
        print("No last command")
    else
        local command = "cexpr system('" .. M.last_command .. "')"
        print(command)
        vim.cmd(command)
    end
    -- Open quickfix window
    if not M.qf_open then
        vim.cmd("copen")
        M.qf_open = true
    end
end

M.toggle_qf = function()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            qf_exists = true
        end
    end
    if qf_exists == true then
        print(":cclose")
        vim.cmd "cclose"
        M.qf_open = false
        return
    end
    if not vim.tbl_isempty(vim.fn.getqflist()) then
        print(":copen")
        vim.cmd "copen"
        M.qf_open = true
    end
end
--===== end Quickfix =====

-- ===== Theme =====
-- Set background
M.set_background = function()
    if vim.o.background == "light" then
        vim.cmd "set background=dark"
    elseif vim.o.background == "dark" then
        vim.cmd "set background=light"
    end
    vim.cmd "2 sleep"
end
-- ===== end Theme =====



-- Although it's called setup function, acctually it only adds some keymaps :P
M.setup = function()
    -- keymaps start with <leader>s, s means self, as this is my personal create functions
    local function opts(description)
        return { desc = description, noremap = true, silent = false }
    end

    if M.send_command ~= nil then
        -- When pressing <leader>ss, execute the send_command function
        vim.keymap.set("n", "<leader>sc", M.send_command, opts("Send command to cexpr"))
    end

    if M.exec_last_command ~= nil then
        vim.keymap.set("n", "<leader>sr", M.exec_last_command, opts("Execute last command sended by send_command"))
    end

    if M.toggle_qf ~= nil then
        vim.keymap.set("n", "<leader>sf", M.toggle_qf, opts("Toggle quickfix list"))
    end
    -- TODO: add cnext, cprev keybind

    if M.set_background ~= nil then
        vim.keymap.set("n", "<leader>sb", M.set_background, opts("Set background"))
    end
end

return M
