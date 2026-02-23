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


-- Delimiters: `~!@#^&*()-_=+[{]}\|\;: '",<.>/?
-- NOTE: $ and % not
-- Try to use Alt-f and Alt-b below
-- aaa`aa'aa aa"aa,aa@aa#aa_aa{aa}aa|aa$aa%aa^aa&aa*aa(aa)aa-aa+aa!aa~aa:aa<aa>aa.aa?aa/aa[aa]aa\aa
M.delimiter_string = "`~!@#^&*()-_=+[{]}\\|;: '\",<.>/?"
M.delimiters = nil

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

--[[
State machine
S2 is the finish state
  | S0 | S1
-------------
N | S1 | S1
D | S0 | S2
--]]

local DIR = {
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
    [IT.N] = { [STATE.S0] = STATE.S1, [STATE.S1] = STATE.S1 },
    [IT.D] = { [STATE.S0] = STATE.S0, [STATE.S1] = STATE.FINISH },
}

local function state_transition(cur_state, input)
    return STM[input] and STM[input][cur_state] or STATE.INVALID
end

local function to_IT(char)
    return is_delimiter(char) and IT.D or IT.N
end

local function find_target_col(state, col, line, direction)
    local limit = direction == DIR.FORWARD and #line or 1
    local step = direction == DIR.FORWARD and 1 or -1
    if line == "" then return false, state end
    for i = col, limit, step do
        local char = line:sub(i, i)
        -- print(i, '"' .. char .. '"') -- Debuging
        state = state_transition(state, to_IT(char))
        if state == STATE.FINISH then
            return true, i
        end
    end
    -- Stop at end of line if col is not at the end of line and the end of line is not delimiter
    if direction == DIR.FORWARD and col ~= limit and not is_delimiter(line:sub(limit, limit)) then return true, limit
    -- Stop at the begin of line if col is not at the beginning of line and the begin of the line is not delimiter
    elseif direction == DIR.BACKWARD and col ~= 1 and not is_delimiter(line:sub(1, 1)) then return true, 1
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

M.process_move = function(key)
    local state = STATE.S0
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row, col = cursor[1], cursor[2] + 1
    local line = vim.api.nvim_get_current_line()
    local direction
    local ok

    state = STATE.S0
    ok = false
    if key == 'f' then
        direction = DIR.FORWARD
        while not ok do
            ok, col = find_target_col(state, col, line, direction)
            if ok then break end
            row, line = find_adjacent_line(row, direction)
            if not row then
                row = vim.api.nvim_buf_line_count(0)
                col = #vim.api.nvim_get_current_line()
                if col < 1 then col = 1 end
                break
            end
            col = 1
        end
    elseif key == 'b' then
        direction = DIR.BACKWARD
        if col > 1 then col = col - 1 end -- Shift back(left) the cursor to be on the delimiter
        while not ok do
            ok, col = find_target_col(state, col, line, direction)
            if ok then
                if is_delimiter(line:sub(col, col)) then
                    col = col + 1 -- Shift right to be let cursor on the right of the delimiter
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
        vim.notify("Invalid key option, valid values are [f, b]", vim.log.levels.ERROR)
        return
    end

    -- Set the new cursor position
    vim.api.nvim_win_set_cursor(0, {row, col - 1})
end

M.setup = function()
    -- Set up delimiter table for quick search
    M.delimiters = create_delimiter_table(M.delimiter_string)
end

return M

