-- NOTE:
-- Below are some examples:
--
-- TODO: do something
-- FIX: this should be fixed
-- HACK: weird code warning
-- WARN:
-- PERF:
-- NOTE:
-- TEST:

local todo_highlight = {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    config = function()
        require('todo-comments').setup()
    end
}

return {
    todo_highlight
}
