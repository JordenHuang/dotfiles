-- ~/.config/nvim/lua/myplugin/init.lua

local M = {}

-- 將資料寫入 quickfix 列表
function M.populate_quickfix()
    local items = {
        { filename = "./test.lua", lnum = 10, col = 1, text = "Error message 1" },
        { filename = "test.lua", lnum = 20, col = 1, text = "Error message 2" },
        { filename = "test.lua", lnum = 30, col = 1, text = "Error message 3" },
    }
    vim.fn.setqflist({}, 'r', { title = 'My Quickfix List', items = items })
    vim.cmd('copen') -- 打開 quickfix 窗口
end

-- 初始化函數
function M.setup()
    -- 將資料寫入 quickfix 列表並打開 quickfix 窗口
    M.populate_quickfix()
end

return M
