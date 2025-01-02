local function opts(description)
    return { desc = description, noremap = true, silent = true }
end

local compilation_mode = {
    'JordenHuang/como.nvim',
    config = function()
        require('como').setup({
            show_last_cmd = true,
            auto_scroll = true,
            preferred_win_pos = "bottom",
            custom_matchers = {
                my = {
                    pattern = "(%S+)-(%d+)-(%d+)-(%S+)-(.+)",
                    parts = { "filename", "lnum", "col", "etype", "message" }
                }
            }
        })

        vim.api.nvim_set_keymap("n", "<leader>cc", ":Como compile<CR>", opts("Como compile"))
        vim.api.nvim_set_keymap("n", "<leader>cr", ":Como recompile<CR>", opts("Como recompile"))
        vim.api.nvim_set_keymap("n", "<leader>cb", ":Como open<CR>", opts("Como focus como buffer"))
        vim.api.nvim_set_keymap("n", "<leader>cv", ":Como toggle<CR>", opts("Como toggle como buffer"))
    end
}

return {
    compilation_mode,
}
