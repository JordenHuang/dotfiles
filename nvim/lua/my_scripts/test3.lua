local function split_commands(cmd)
    local cmds = {}
    local current = ""
    local i = 1
    while i <= #cmd do
        local char = cmd:sub(i, i)
        if char == '&' and cmd:sub(i, i+1) == '&&' then
            table.insert(cmds, {command=current, operator='&&'})
            current = ""
            i = i + 1
        elseif char == '|' and cmd:sub(i, i+1) == '||' then
            table.insert(cmds, {command=current, operator='||'})
            current = ""
            i = i + 1
        elseif char == ';' then
            table.insert(cmds, {command=current, operator=';'})
            current = ""
        else
            current = current .. char
        end
        i = i + 1
    end
    table.insert(cmds, {command=current, operator=nil})
    return cmds
end

local uv = vim.loop

local function execute_commands(commands, index, previous_success, on_complete)
    if index > #commands then
        on_complete()
        return
    end

    local cmd = commands[index]
    local stdout = uv.new_pipe(false)
    local stderr = uv.new_pipe(false)

    local args = {}
    for arg in cmd.command:gmatch("%S+") do
        table.insert(args, arg)
    end

    local handle, pid
    handle, pid = uv.spawn(args[1], {
        args = { select(2, unpack(args)) },
        stdio = {nil, stdout, stderr}
    }, function(code, signal)
            stdout:read_stop()
            stderr:read_stop()
            stdout:close()
            stderr:close()
            handle:close()

            local success = (code == 0)
            if cmd.operator == '&&' and success or cmd.operator == '||' and not success or cmd.operator == ';' then
                execute_commands(commands, index + 1, success, on_complete)
            else
                if on_complete then on_complete() end
            end
        end)

    stdout:read_start(function(err, data)
        assert(not err, err)
        if data then
            -- vim.api.nvim_out_write(data)
            print(data)
        end
    end)

    stderr:read_start(function(err, data)
        assert(not err, err)
        if data then
            -- vim.api.nvim_err_write(data)
            print(data)
        end
    end)
end

function My_exec_complex_command(cmd, on_complete)
    local commands = split_commands(cmd)
    execute_commands(commands, 1, true, on_complete)
end

