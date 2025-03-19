local function opts(description)
    return { desc = description, noremap = true, silent = true }
end

local file_manager = {
    dir = "~/mnvp/neovim_and_lua/simdir.nvim",
    config = function()
        require('simdir').setup({
            default_file_explorer = true,
            use_trash_can_when_remove = true,
            keymaps = {
                ["<CR>"] = "open",
                ["o"] = "open",
                ["O"] = "open_split",
                ["-"] = "parent_dir",
                ["T"] = "touch",
                ["+"] = "mkdir",
                ["R"] = "rename",
                ["M"] = "move",
                ["C"] = "copy",
                ["m"] = "mark",
                ["d"] = "d_mark",
                ["u"] = "unmark",
                ["U"] = "unmark_all",
                ["i"] = "invert_mark",
                ["X"] = "remove",
                ["r"] = "reload",
                ["s!"] = "shell_command",
            }
        })

        -- Set up some keymaps
        vim.api.nvim_set_keymap("n", "<leader>sp", ":Simdir open_parent_dir<CR>", opts("Simdir open parent directory"))
        vim.api.nvim_set_keymap("n", "<leader>so", ":Simdir open_dir<CR>", opts("Simdir open directory"))
        vim.api.nvim_set_keymap("n", "<leader>se", ":Simdir open_last<CR>", opts("Simdir open last buffer"))
    end
}

local compilation_mode = {
    -- dir = '~/mnvp/neovim_and_lua/como.nvim',
    "JordenHuang/como.nvim",
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
    -- file_manager,
    compilation_mode,
}
