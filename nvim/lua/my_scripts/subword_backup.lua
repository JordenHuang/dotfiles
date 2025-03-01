local M = {}

--[[
Rule:
Forward:
if char under cursor is not a delimiter char,
    then check if the cursor is at the end of the line
        if true, then find the next non-empty line, and find the next delim char, set cursor to there
        if false, just find the next delim char, if not found, then set cursor to the end of the line
else if the char under cursor is a delimiter char,
    then check if the cursor is at the end of the line
        if true, then find the next non-empty line, and find the next non-delim char, and find the next delim char, set cursor to there
        if false, skips the following delim chars until a non-delim char, and find the next delim char,
            if not found, then set cursor to the end of the line
--]]


-- `~!@#^&*()-_=+[{]}\|\;: '",<.>/?
-- NOTE: $ and % not
-- Try to use alt-f below
-- aaa`aa'aa aa"aa,aa@aa#aa_aa{aa}aa|aa$aa%aa^aa&aa*aa(aa)aa-aa+aa!aa~aa:aa<aa>aa.aa?aa/aa[aa]aa\aa
M.delimiter_string = "`~!@#^&*()-_=+[{]}\\|;: '\",<.>/?"
M.delimiters = nil

--[[
:::
:::
:
::
:::
:::
::
:
--]]

local function create_delimiter_table(delim_string)
    local delim_table = {}
    for char in delim_string:gmatch(".") do
        delim_table[char] = true
    end
    return delim_table
end

local function is_delimiter(char)
    return M.delimiters[char] or false
end

-----------------
--[[
local function get_next_line(row)
    local line
    local limit = vim.api.nvim_buf_line_count(0)
    row = row + 1
    while row < limit do
        line = vim.api.nvim_buf_get_lines(0, row-1, row, true)[1] -- Row index in api is zero-based
        print(row, line)
        -- Make sure the line is not empty
        if line ~= "" then
            -- Make sure the line contains any non-delim char
            local flag = false
            for i=1, #line do
                if not is_delimiter(line:sub(i, i)) then
                    flag = true
                    break
                end
            end

            if flag then break
            else row = row + 1 end
        else
            row = row + 1
        end
    end
    return row, 0, line
end

-- Use this function when cursor is on a delim char
-- it wants to skip the following up delim chars
local function find_next_non_delimiter(row, col, line)
    local final_pos = {row, col}
    local flag = true
    for i=col+1, #line do
        if not is_delimiter(line:sub(i, i)) then
            final_pos[2] = i
            flag = false
            break
        end
    end

    -- Until the end of line, it's still a delimiter
    -- so search the next line
    if flag then
        row, col, line = get_next_line(row)
        final_pos[1] = row
        for i=col+1, #line do
            if not is_delimiter(line:sub(i, i)) then
                final_pos[2] = i - 1
                break
            end
        end
    end
    return final_pos
end

local function find_next_delimiter(row, col, line)
    local final_pos = {row, col}
    for i=col+1, #line do
        if is_delimiter(line:sub(i, i)) then
            final_pos[2] = i - 1
            break
        end

        -- If not found the next delim char, then
        -- set cursor to the end of the line
        if i == #line then
            final_pos[2] = #line
        end
    end
    return final_pos
end

local function get_next_line_and_first_non_delimiter(row, col, line)
    local pos
    row, col, line = get_next_line(row)
    pos = find_next_non_delimiter(row, col, line)
    row, col = pos[1], pos[2]
    return row, col, line
end

--]]
-------------------------
--[[
local function find_adjacent_line(row, direction)
    local limit = vim.api.nvim_buf_line_count(0)
    row = row + direction
    while row >= 1 and row <= limit do
        local line = vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]
        -- Empty line
        if line ~= "" then
            return row, line
        end
        row = row + direction
    end
    return nil, nil -- No valid line found
end

local function skip_delimiters(line, start_col, direction)
    local limit = direction > 0 and #line or 1
    local step = direction > 0 and 1 or -1
    for i=start_col, limit, step do
        if not is_delimiter(line:sub(i, i)) then
            return i
        end
    end
    return nil
end

local function find_first_delimiter(line, start_col, direction)
    local limit = direction > 0 and #line or 1
    local step = direction > 0 and 1 or -1
    local target_col
    for i = start_col, limit, step do
        local char = line:sub(i, i)
        if is_delimiter(char) then
            print(i, '"' .. char .. '"')
            return i
        end
    end
    return nil -- No match found
end

local function find_target(line, start_col, direction, start_is_delim)
    local limit = direction > 0 and #line or 1
    local step = direction > 0 and 1 or -1
    local target_col
    if start_is_delim then
        -- skip the following delimiters
        target_col = skip_delimiters(line, start_col + direction, direction)
        if not target_col then
            -- TODO:
            return nil
        else
            target_col = find_first_delimiter(line, target_col + direction, direction)
            return target_col
        end
    end
end

M.process_move = function(key, direction)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row, col = cursor[1], cursor[2] + 1
    local line = vim.api.nvim_get_current_line()

    local limit = vim.api.nvim_buf_line_count(0)
    local start_is_delim = is_delimiter(line:sub(col, col))
    local target_cursor = cursor
    local target_col
    -- print(row, col, char_is_delim)

    -- if row == limit then return end

    if key == 'f' then
        target_col = find_target(line, col + direction, direction, start_is_delim)
    end

    -- Set the new cursor position
    if target_col then
        vim.api.nvim_win_set_cursor(0, {row, target_col - 1})
    end
end
--]]
-----------------

--[[
State machine
S2 is the finish state
  | S0 | S1
-------------
N | S1 | S1
D | S0 | S2
--]]

M.DIR = {
    FORWARD = 1,
    BACKWARD = -1
}

-- Input type
local IT= {
    N = 1,
    D = 2
}

-- States in state machine
local STATE = {
    S0 = 1,
    S1 = 2,
    FINISH = 3,
    INVALID = -1
}

local STM = {
    { STATE.S1, STATE.S1 },
    { STATE.S0, STATE.FINISH }
}

local function state_transition(cur_state, input)
    return STM[input][cur_state]
end

local function to_IT(char)
    return is_delimiter(char) and IT.D or IT.N
end

local function find_target_col(state, col, line, direction)
    local limit = direction == M.DIR.FORWARD and #line or 1
    local step = direction == M.DIR.FORWARD and 1 or -1
    if line == "" then return false, state end
    for i = col, limit, step do
        local char = line:sub(i, i)
        print(i, '"' .. char .. '"')
        state = state_transition(state, to_IT(char))
        if state == STATE.FINISH then
            if direction == M.DIR.BACKWARD then
                return true, i
            else
                return true, i
            end
        end
    end
    -- Stop at end of line if col is not the end of line and the end of line is not delimiter
    if direction == M.DIR.FORWARD and col ~= limit and not is_delimiter(line:sub(limit, limit)) then return true, limit
    elseif direction == M.DIR.BACKWARD and col ~= 1 and not is_delimiter(line:sub(1, 1)) then return true, 1
    else return false, state end -- No match found in current line
end

local function find_adjacent_line(row, direction)
    local limit = vim.api.nvim_buf_line_count(0)
    row = row + direction
    while row >= 1 and row <= limit do
        local line = vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]
        -- Non-empty line
        if line ~= "" then
            return row, line
        end
        row = row + direction
    end
    return nil, nil -- No valid line found
end

M.process_move = function(key, direction)
    local state = STATE.S0
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row, col = cursor[1], cursor[2] + 1
    local line = vim.api.nvim_get_current_line()

    local limit = vim.api.nvim_buf_line_count(0)
    local ok

    state = STATE.S0
    ok = false
    if key == 'f' then
        while not ok do
            ok, col = find_target_col(state, col, line, direction)
            if ok then break end
            row, line = find_adjacent_line(row, direction)
            if not row then
                row = limit
                col = #vim.api.nvim_get_current_line()
                break
            end
            col = 1
        end
    elseif key == 'b' then
        -- local right_shift = false
        if col > 1 then col = col - 1 end
        while not ok do
            ok, col = find_target_col(state, col, line, direction)
            if ok then
                if is_delimiter(line:sub(col, col)) then
                    -- right_shift = true
                    -- if right_shift then col = col + 1 end
                    col = col + 1
                end
                break
            end
            row, line = find_adjacent_line(row, direction)
            if not row then
                row = 1
                col = 1
                break
            end
            col = #line
        end
    else
        vim.notify("Invalid key", vim.log.levels.ERROR)
        return
    end

    -- Set the new cursor position
    -- if target_col then
        vim.api.nvim_win_set_cursor(0, {row, col - 1})
    -- end
end

M.setup = function()
    -- Set up delimiter table for quick search
    M.delimiters = create_delimiter_table(M.delimiter_string)
    vim.keymap.set({'n', 'i', 'v', 'o'}, "<A-f>", function() return M.process_move('f', M.DIR.FORWARD) end, {}) --opts("Subword forward"))
    vim.keymap.set({'n', 'i', 'v', 'o'}, "<A-b>", function() return M.process_move('b', M.DIR.BACKWARD) end, {}) --opts("Subword forward"))
end

return M

