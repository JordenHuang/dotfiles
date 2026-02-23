-- TODO:
-- 1. terminal in a split, set buffer local map that performs `cgetbuf`

local M = {}

local state = {
    split = {
        buf = -1,
        win = -1,
    },
    floating = {
        ratio = 0.4,
        buf = -1,
        win = -1,
    }
}

--[[ Split terminal ]]--
local function create_split_window(opts)
    opts = opts or {}

    -- Create a buffer
    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
    end

    local win_config = {
        split = "below",
    }

    -- Create the split window
    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end

M.toggle_split_terminal = function()
    if not vim.api.nvim_win_is_valid(state.split.win) then
        state.split = create_split_window({ buf = state.split.buf })
        local buf_nr = state.split.buf
        local win_nr = state.split.win
        if vim.bo[buf_nr].buftype ~= "terminal" then
            vim.cmd.terminal()
            -- config it
            vim.api.nvim_set_option_value("number", false, {win=win_nr})
            vim.api.nvim_set_option_value("relativenumber", false, {win=win_nr})
            local rows = math.floor(vim.o.lines * 0.35)
            vim.api.nvim_win_set_height(win_nr, rows)
        end
    else
        vim.api.nvim_win_hide(state.split.win)
    end
end

--[[ Float terminal ]]--
local function create_floating_window(opts)
    opts = opts or {}
    -- local width = opts.width or math.floor(vim.o.columns * opts.ratio)
    local width = vim.o.columns
    local height = opts.height or math.floor(vim.o.lines * opts.ratio)

    -- Calculate the position to center the window
    -- local col = math.floor((vim.o.columns - width) / 2)
    -- local row = math.floor((vim.o.lines - height) / 2)
    local row = vim.o.lines - height
    local col = 0

    -- Create a buffer
    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
    end

    -- Define window configuration
    local win_config = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal", -- No borders or extra UI elements
        border = { "", "─", "", "", "", "", "", "" },
        title = "Terminal",
        title_pos = "left",
    }

    -- Create the floating window
    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end


M.toggle_floating_terminal = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = create_floating_window { buf = state.floating.buf }
        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end
    else
        vim.api.nvim_win_hide(state.floating.win)
    end
end

M.setup = function()
    vim.api.nvim_create_autocmd({"TermEnter"}, {
        pattern = {"Term*"},
        callback = function()
            vim.cmd("startinsert")
        end
    })
    local opts = {buffer = state.split.buf}
    vim.keymap.set("t", "<leader>t", M.toggle_split_terminal, opts)
    vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", opts)
    vim.keymap.set("t", "<A-h>", "<cmd>wincmd h<CR>", opts)
    vim.keymap.set("t", "<A-j>", "<cmd>wincmd j<CR>", opts)
    vim.keymap.set("t", "<A-k>", "<cmd>wincmd k<CR>", opts)
    vim.keymap.set("t", "<A-l>", "<cmd>wincmd l<CR>", opts)
end

return M
