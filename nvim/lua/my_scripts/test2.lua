-- ~/.config/nvim/lua/compilation_mode.lua

local M = {}

-- 創建和打開一個新的緩衝區
function M.create_compilation_buffer()
    -- 創建新的緩衝區
    vim.cmd('vnew')
    local buf = vim.api.nvim_get_current_buf()

    -- 設置緩衝區名稱
    vim.api.nvim_buf_set_name(buf, 'Compilation Output')

    -- 設置緩衝區為只讀
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)
    vim.api.nvim_buf_set_option(buf, 'readonly', true)

    -- 設置緩衝區不列入緩衝區列表
    vim.api.nvim_buf_set_option(buf, 'buflisted', false)

    -- 設置語法高亮
    vim.cmd('setlocal syntax=messages')

    -- 返回緩衝區ID
    return buf
end

-- 寫入訊息到緩衝區
function M.write_to_buffer(buf, lines)
    -- 允許寫入
    vim.api.nvim_buf_set_option(buf, 'modifiable', true)

    -- 寫入訊息
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    -- 恢復只讀
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)
end

-- 插入測試訊息
-- function M.insert_test_message()
--     local buf = M.create_compilation_buffer()
--     local lines = {
--         "Compilation started at Tue Jun 15 10:00:00",
--         "",
--         "test.c:10:1: error: expected ‘;’ before ‘return’",
--         "main() {",
--         " ^",
--         "return 0;",
--         "}",
--         "",
--         "Compilation finished at Tue Jun 15 10:00:05",
--     }
--     M.write_to_buffer(buf, lines)
-- end

-- 跳轉到錯誤位置
function M.jump_to_error()
    print('ininin')
    local line = vim.fn.getline('.')
    local file, lnum = string.match(line, '([^:]+):(%d+):')
    if file and lnum then
        -- vim.cmd('edit +' .. lnum .. ' ' .. file)
        vim.cmd('edit ' .. file)
        vim.cmd(tostring(lnum))
    end
end

-- 插入測試訊息並添加跳轉功能
function M.insert_test_message()
    local buf = M.create_compilation_buffer()
    local lines = {
        "Compilation started at Tue Jun 15 10:00:00",
        "",
        "test.c:10:1: error: expected ‘;’ before ‘return’",
        "main() {",
        " ^",
        "return 0;",
        "}",
        "",
        "Compilation finished at Tue Jun 15 10:00:05",
    }
    M.write_to_buffer(buf, lines)

    -- 設置快捷鍵處理跳轉
end

-- 初始化函數
function M.setup()
    vim.keymap.set('n', '<leader>na', M.insert_test_message, { noremap = true, silent = true })
    vim.keymap.set( 'n', '<CR>', M.jump_to_error, { noremap = true, silent = true })
    -- vim.cmd(insert_test_message()')
end

return M
