local M = {}

--===== Quickfix list =====
M.send_command = function()
    vim.ui.input(
        { prompt = "Command: " }, 
        function(cmd)
            if cmd == nil then
                print("Empty input, abort")
                return
            end
            local command = "cexpr system('" .. cmd .. "')"
            print(":" .. command)
            vim.cmd(command)
        end
    )
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
        return
    end
    if not vim.tbl_isempty(vim.fn.getqflist()) then
        print(":copen")
        vim.cmd "copen"
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
    vim.cmd "1 sleep"
end
-- ===== end Theme =====



-- Although it's called setup function, acctually it only adds some keymaps :P
M.setup = function()
    -- keymaps start with <leader>s, s means self, as this is my personal create functions
    local function opts(description)
        return { desc = description, noremap = true, silent = false }
    end

    if M.send_command ~= nil then
        vim.keymap.set("n", "<leader>sc", M.send_command, opts("Send command to cexpr"))
    end

    if M.toggle_qf ~= nil then
        vim.keymap.set("n", "<leader>sf", M.toggle_qf, opts("Toggle quickfix list"))
    end

    if M.set_background ~= nil then
        vim.keymap.set("n", "<leader>sb", M.set_background, opts("Set background"))
    end
end

return M
