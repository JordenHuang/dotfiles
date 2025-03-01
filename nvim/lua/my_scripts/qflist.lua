-- TODO: make a plugin that contains some useful
-- quickfix list utils
local M = {}

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

-- TODO: Think how to use this function
local function To_qf()
    -- local bufnr = vim.api.nvim_get_current_buf()
    local row = vim.api.nvim_win_get_cursor(0)[1]
    -- vim.print(vim.api.nvim_buf_get_lines(0, row-1, -1, true))
    local lines = {}
    lines['lines'] = vim.api.nvim_buf_get_lines(0, row-1, -1, true)
    vim.fn.setqflist({}, 'r', lines)
    -- for k, v in pairs(vim.api.nvim_buf_get_lines(0, row-1, -1, true)) do
    --     print(k, v)
    -- end
end

return M
