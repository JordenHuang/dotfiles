local M = {}

M.last_command = nil

M.get_cmd = function()
    local cmd
    vim.ui.input(
        {
            prompt = "Command: ",
            default = M.last_command,
            -- Use "shellcmdline" instead (Neovim 0.11 or above)
            completion = "customlist,v:lua.require'my_scripts.qflist'.compile_completion",
        },
        function(input)
            cmd = input
        end
    )
    return cmd
end

M.compile_run = function()
    M.exec_and_to_qflist(M.get_cmd())
end

M.compile_rerun = function()
    M.exec_and_to_qflist(M.last_command)
end

M.exec_and_to_qflist = function(cmd)
    if cmd == '' or cmd == nil then
        print("Empty command, abort")
        return
    end
    M.last_command = cmd
    local command = "cgetexpr system('" .. cmd .. "')"
    vim.cmd(command)
    vim.cmd("copen")
end

M.toggle_qf = function()
    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            print(":cclose")
            vim.cmd "cclose"
            return
        end
    end
    if not vim.tbl_isempty(vim.fn.getqflist()) then
        print(":copen")
        vim.cmd "copen"
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

-- Need Nvim 0.11 to have "shellcmdline" option
M.compile_completion = function(ArgLead, CmdLine, CursorPos)
    -- split command line into words
    local words = vim.split(CmdLine, "%s+")
    local is_first_arg = (#words <= 1) -- Compile <arg>

    if is_first_arg then
        -- program completion
        return vim.fn.getcompletion(ArgLead, "shellcmd")
    else
        -- file completion
        return vim.fn.getcompletion(ArgLead, "file")
    end
end

-- local function cmdline_compile_completion(ArgLead, CmdLine, CursorPos)
--     -- split command line into words
--     local words = vim.split(CmdLine, "%s+")
--     vim.print(words)
--     local is_first_arg = (#words == 2) -- Compile <arg>
--     local is_second_arg = (#words == 3) -- Compile run <arg>
--
--     if is_first_arg then
--         return { "run", "rerun" }
--     elseif is_second_arg and words[2] == "run" then
--         -- program completion
--         return vim.fn.getcompletion(ArgLead, "shellcmd")
--     elseif words[2] ~= "rerun" then
--         -- file completion
--         return vim.fn.getcompletion(ArgLead, "file")
--     end
-- end

-- M.setup = function()
--     vim.api.nvim_create_user_command("Compile", function(opts)
--         local words = vim.split(opts.args, "%s+")
--         if words[1] == "run" then
--             M.exec_and_to_qflist(table.concat(words, " ", 2))
--         elseif words[1] == "rerun" then
--             M.compile_rerun()
--         end
--     end, {
--             nargs = "+",
--             complete = cmdline_compile_completion,
--         })
-- end

return M
