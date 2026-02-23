local M = {}

local function capture_eval(code)
    local output = {}
    local old_print = print
    print = function(...)
        local args = {...}
        local str_args = {}
        for _, v in ipairs(args) do table.insert(str_args, vim.inspect(v)) end
        table.insert(output, table.concat(str_args, "  "))
    end

    local func, err = load("return " .. code)
    if not func then func, err = load(code) end

    local ok, result = false, nil
    if func then
        ok, result = pcall(func)
    else
        result = "-- Syntax Error: " .. (err or "unknown")
    end

    -- 還原 Print
    print = old_print

    local final_lines = {}
    -- print function
    for _, line in ipairs(output) do table.insert(final_lines, "-- " .. line) end
    -- Other statements
    if ok and (result ~= nil or #output == 0) then
        table.insert(final_lines, "-- " .. vim.inspect(result))
    elseif not ok then
        table.insert(final_lines, "-- Error: " .. tostring(result))
    end

    return final_lines
end

-- Line Evaluation
function M.eval_line()
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local line_content = vim.api.nvim_get_current_line()
    local results = capture_eval(line_content)
    vim.api.nvim_buf_set_lines(0, row, row, false, results)
end

-- Visual Selection Evaluation
function M.eval_visual()
    local mode = vim.fn.mode()
    local start_pos = vim.fn.getpos("v")
    local end_pos = vim.fn.getpos(".")

    -- 取得選取的程式碼
    local lines = vim.fn.getregion(start_pos, end_pos, { type = mode })
    local code = table.concat(lines, "\n")

    -- 取得插入位置（選取的最後一行）
    local erow = math.max(start_pos[2], end_pos[2])
    local results = capture_eval(code)

    vim.api.nvim_buf_set_lines(0, erow, erow, false, results)
    -- 結束選取模式回到 Normal mode
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
end

-- Buffer Evaluation
function M.eval_buffer()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local code = table.concat(lines, "\n")
    local results = capture_eval(code)
    -- 在文件最後插入
    vim.api.nvim_buf_set_lines(0, -1, -1, false, results)
end

-- 插件初始化與設定
-- 設定 Scratch Buffer 的屬性
function M.setup_scratch_buffer(is_vim_enter)
    local buf
    if is_vim_enter then
        buf = vim.api.nvim_get_current_buf()
    else
        buf = vim.api.nvim_create_buf(true, false)
    end

    -- 設定緩衝區為不儲存檔案、無名稱的臨時狀態
    vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
    -- vim.api.nvim_set_option_value("bufhidden", "hide", { buf = buf })
    vim.api.nvim_set_option_value("swapfile", false, { buf = buf })
    vim.api.nvim_set_option_value("filetype", "lua", { buf = buf }) -- 支援語法高亮

    vim.api.nvim_buf_set_name(buf, "*Scratch*")

    -- 初始歡迎文字
    local header = {
        "-- Welcome to Neovim Scratch Buffer (Lua)",
        "-- Press <leader>x to eval line, <leader>X to eval buffer",
        "",
    }
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, header)

    local opts = { buffer = buf, silent = true }
    vim.keymap.set("n", "<leader>x", M.eval_line, opts)
    vim.keymap.set("v", "<leader>x", M.eval_visual, opts)
    vim.keymap.set("n", "<leader>X", M.eval_buffer, opts)
end

function M.setup()
    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            -- 如果緩衝區為空且沒有檔案名稱
            if vim.fn.argc() == 0 and vim.api.nvim_buf_get_name(0) == "" and vim.bo.filetype == "" then
                M.setup_scratch_buffer(true)
            else
                M.setup_scratch_buffer(false)
            end
        end,
    })
end

return M
