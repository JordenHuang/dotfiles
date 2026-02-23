-- function callback(opts)
local set_local_keymaps = function(callback)
    local opts = {buffer = 0}
    callback(opts)
end

-- From toggleterm.nvim: https://github.com/akinsho/toggleterm.nvim/blob/main/lua/toggleterm/terminal.lua#L23-L34
local is_windows = vim.fn.has("win32") == 1

local function is_cmd(shell) return shell:find("cmd") end

local function is_pwsh(shell) return shell:find("pwsh") or shell:find("powershell") end

local function is_nushell(shell) return shell:find("nu") end

local function get_command_sep() return is_windows and is_cmd(vim.o.shell) and "&" or ";" end

local function get_comment_sep() return is_windows and is_cmd(vim.o.shell) and "::" or "#" end

local M = {}

M.group_id = nil

M.term_list = {}

M.new_term = function()
    local term_nr = #M.term_list + 1
    -- Find hold
    -- for i, v in ipairs(M.term_list) do
    --     print(i, v)
    --     if v == nil then
    --         term_nr = i
    --     end
    -- end

    -- Create a buffer
    local buf_nr = vim.api.nvim_create_buf(true, false);
    local term_info = {
        term = term_nr,
        name = string.format("Term_%d" ,term_nr),
        job_id = nil,
        buf = buf_nr,
        win = nil,
        type = nil,
    }
    -- Add to term list
    M.term_list[term_nr] = term_info

    -- Buffer local autocommand
    -- vim.api.nvim_create_autocmd("TermClose", {
    --     group = M.group_id,
    --     buffer = buf_nr,
    --     callback = function() M.delete_term(buf_nr) end,
    -- })
end


-- M.delete_term = function(term_nr)
--     if M.term_list[term_nr] then
--         M.term_list[term_nr] = nil
--     end
-- end

M.list_term = function()
end

-- local function cleanup_term_list()
--     for i, v in ipairs(M.term_list) do
--         if not vim.api.nvim_buf_is_valid(v.buf) then
--             table.remove(M.term_list, i)
--         end
--     end
-- end

M.open_split = function()
    local split = "below"

    -- if #M.term_list == 0 then M.new_term() end
    M.new_term()

    local term = M.term_list[#M.term_list]
    local buf_nr = term.buf
    -- Create window, set buf to that window
    local win_nr = vim.api.nvim_open_win(buf_nr, true, { split = split, win = 0 })

    -- Open terminal
    local shell = vim.o.shell
    local command_sep = get_command_sep()
    local comment_sep = get_comment_sep()
    local cmd = table.concat({
        shell,
        command_sep,
        comment_sep,
        term.name,
        comment_sep,
    })
    local job_id = vim.fn.termopen(cmd, { detach = 1 })
    M.term_list[term.term].job_id = job_id

    -- Config it
    vim.api.nvim_set_option_value("number", false, {win=win_nr})
    vim.api.nvim_set_option_value("relativenumber", false, {win=win_nr})
end

M.open_vsplit = function(term_nr)
end

M.open_float = function(term_nr)
end

M.toggle_term = function(term_nr)
end

M.clear_term = function()
end

M.send_cmd = function(term_nr, cmd)
end

-- M.toggle_split_terminal = function()
--     if not vim.api.nvim_win_is_valid(state.split.win) then
--         state.split = create_split_window { buf = state.split.buf }
--         if vim.bo[state.split.buf].buftype ~= "terminal" then
--             vim.cmd.terminal()
--         end
--     else
--         vim.api.nvim_win_hide(state.split.win)
--     end
-- end

M.matcher_set = {
    gcc = {
        pattern = "(%S+):(%d+):(%d+): (%S+): (.+)",
        parts = { "filename", "lnum", "col", "etype", "message" }
    },
    python = {
        pattern = "  File \"(%S+)\", line (%d+), (.+)",
        parts = {
            [1] = "filename",
            [2] = "lnum",
            [3] = "message"
        }
    },
    shell = {
        pattern = "(%S+): line (%d+): (.+)",
        parts = { "filename", "lnum", "message" }
    },
    rust = {
        pattern = " --> (%S+):(%d+):(%d+)",
        parts = { "filename", "lnum", "col" }
    },
    grep = {
        pattern = "(%S+):(%d+):(.+)",
        parts = { "filename", "lnum", "message" }
    }
}

M.Pos = {
    name = 1,
    start_col = 2,
    end_col = 3,
    data = 4
}

M.parse_line = function(line)
    local matched_most = -1
    local matched_result = nil
    for mname, matcher in pairs(M.matcher_set) do
        local res = {}
        local values = { string.match(line, matcher.pattern) }
        -- for a, b in ipairs(values) do
        --     print(a, b)
        -- end

        if #values ~= 0 and #values > matched_most then
            -- res.mname = mname
            -- res.mpattern = matcher.pattern
            res.parts = M.calc_position(matcher.parts, values, line)

            matched_most = #values
            matched_result = res
        end
    end

    if matched_most ~= -1 then
        return matched_result
        -- return res
    else
        return nil
    end
end

M.calc_position = function(parts, values, line)
    local res = {}
    local start_col, end_col
    local next_start = 1
    for i = 1, #values do
        -- Needs to give 'plain' argument, or some operator in parts[i] will be treated as 'magic'. See :h string.find()
        start_col, end_col = string.find(line, values[i], next_start, true)

        start_col = tonumber(start_col)
        end_col = tonumber(end_col)
        next_start = end_col + 1

        -- parts[i] is the part's name, like filename, lnum .etc
        res[i] = { parts[i], start_col, end_col, values[i] }
    end
    -- print(vim.inspect(res))
    return res
end

M.open_file_and_set_cursor = function(file_path, row, col)
    local is_file_open = false
    local win_id = nil
    local has_last_win = false

    -- Iterate over all windows to check if the file is already open
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local buf_name = vim.api.nvim_buf_get_name(buf)
        if buf_name == file_path then
            is_file_open = true
            win_id = win
            break
        elseif win == M.jmp_to_file_win then
            has_last_win = true
            win_id = win
            -- Don't break because the file might have opened in other windows
        end
    end

    if is_file_open and win_id then
        -- Focus the window where the file is open
        vim.api.nvim_set_current_win(win_id)
    elseif has_last_win and win_id then
        -- If last used window exist, use that window
        vim.api.nvim_set_current_win(win_id)
        vim.cmd('edit ' .. file_path)
    else
        -- Open a new window below and open the file
        vim.cmd('belowright split ' .. file_path)
    end
    M.jmp_to_file_win = vim.api.nvim_get_current_win()

    -- Set the cursor position
    if col then
        -- let col minus 1 because it's 0-indexed
        vim.api.nvim_win_set_cursor(0, {row, col-1})
    else
        vim.api.nvim_win_set_cursor(0, {row, 0})
    end
end

-- Jump to the file
M.jump_to_file = function()
    local line = vim.api.nvim_get_current_line()
    -- print('current line: ' .. line)

    local result = M.parse_line(line)
    if result == nil then
        return nil
    end

    -- Variables with default value nil
    local file_path, lnum, col
    -- Loop through the parts in the line, to get the filename, lnum (and probrobly col)
    for _, part in ipairs(result.parts) do
        -- Get the filename
        if part[M.Pos.name] == "filename" then
            -- print("The 'only' filename: ")
            -- print(vim.fn.fnamemodify(part[Pos.data], ":t"))

            file_path = vim.fn.fnamemodify(part[M.Pos.data], ":p")
            -- Try to find the file with its full path
            local ok, err = vim.uv.fs_stat(file_path)
            if not ok then
                vim.notify("Error to find file:", vim.log.levels.ERROR)
                vim.notify(err, vim.log.levels.ERROR)
                return nil
                -- else
                --     print(file_path)
                --     print("no problem")
            end
        end

        -- Get the line number
        if part[M.Pos.name] == "lnum" then
            lnum = tonumber(part[M.Pos.data])
        end

        -- Get the column number
        if part[M.Pos.name] == "col" then
            col = tonumber(part[M.Pos.data])
        end
    end

    if file_path ~= nil and lnum ~= nil then
        -- Escape the filename contians modifiers like "\t\n*?[{`$\\%#'\"|!<"
        file_path = vim.fn.fnameescape(file_path)
        M.open_file_and_set_cursor(file_path, lnum, col)
    else
        return nil
    end
end


local MyEscTimer = nil
M.setup = function()
    M.group_id = vim.api.nvim_create_augroup("MyGroup", {
        clear = false
    })

    -- vim.api.nvim_create_autocmd({"BufEnter"}, {
    --     group = M.group_id,
    --     pattern = {"term://*Term*"},
    --     callback = function()
    --         vim.cmd('startinsert')
    --     end
    -- })

    vim.api.nvim_create_autocmd({"TermOpen"}, {
        group = M.group_id,
        pattern = {"term://*Term*"},
        callback = function(args)
            local opts = {buffer = args.buf}

            vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
            vim.keymap.set("t", "<A-h>", "<cmd>wincmd h<CR>", opts)
            vim.keymap.set("t", "<A-j>", "<cmd>wincmd j<CR>", opts)
            vim.keymap.set("t", "<A-k>", "<cmd>wincmd k<CR>", opts)
            vim.keymap.set("t", "<A-l>", "<cmd>wincmd l<CR>", opts)

    vim.keymap.set('n', "<CR>", M.jump_to_file, opts)

            -- -- Double tap to enter normal mode from terminal mode
            -- vim.keymap.set("t", "<Esc>", function()
            --     MyEscTimer = MyEscTimer or (vim.uv or vim.loop).new_timer()
            --     if MyEscTimer:is_active() then
            --         MyEscTimer:stop()
            --         vim.cmd("stopinsert")
            --     else
            --         MyEscTimer:start(200, 0, function() end)
            --         return "<Esc>"
            --     end
            -- end, opts)

            -- Start in insert mode
            vim.cmd("startinsert")
        end
    })
end

return M
