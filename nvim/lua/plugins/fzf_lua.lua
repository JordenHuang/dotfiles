local my_winopt = {
    row        = 1,
    col        = 0,
    width      = 1,
    height     = 0.45,
    layout     = "horizontal",
    horizontal = "left:50%",
    border     = { "", "─", "", "", "", "", "", "" },
    preview    = {
        width       = 1,
        height      = 0.45,
        layout      = "horizontal",
        horizontal  = "right:50%",
        border      = { "┬", "─", "", "", "", "", "", "│" },
        wrap        = true,
    }
}

local fzf_lua = {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "nvim-mini/mini.icons" },
    ---@module "fzf-lua"
    ---@type fzf-lua.Config|{}
    ---@diagnostics disable: missing-fields
    opts = {},
    ---@diagnostics enable: missing-fields
    config = function()
        require("fzf-lua").setup({
            fzf_colors = true,

            builtin = {
                winopts = my_winopt,
            },
            files = {
                winopts = my_winopt,
                hidden = true,
                no_ignore = true,
            },
            buffers = {
                winopts = my_winopt,
            },
            live_grep = {
                winopts = my_winopt,
            },

            keymap = {
                -- Below are the default binds, setting any value in these tables will override
                -- the defaults, to inherit from the defaults change [1] from `false` to `true`
                builtin = {
                    -- neovim `:tmap` mappings for the fzf win
                    true,  -- uncomment to inherit all the below in your custom config
                    ["<C-d>"] = "preview-page-down",
                    ["<C-u>"] = "preview-page-up",
                },
            }
        })

        -- Keymaps
        local function opts(description)
            return { desc = description, noremap = true, silent = true }
        end

        local function ask_path()
            local cwd = vim.fn.expand("%:p:h").."/"
            vim.ui.input(
                { prompt = "Search path: ", default = cwd, completion = "file"},
                function(cmd)
                    if cmd == nil or cmd == '' then
                        return
                    else
                        vim.cmd(":FzfLua files cwd=" .. cmd)
                    end
                end
            )
        end

        vim.keymap.set("n", "<leader>ff", ":FzfLua files<CR>", opts("FzfLua files, in cwd"))
        vim.keymap.set("n", "<leader>fF", ask_path, opts("FzfLua files, with path"))
        vim.keymap.set("n", "<leader>fb", ":FzfLua buffers<CR>", opts("FzfLua buffers"))
        vim.keymap.set("n", "<leader>fh", ":FzfLua helptags<CR>", opts("FzfLua helptags"))
        vim.keymap.set("n", "<leader>fl", ":FzfLua live_grep<CR>", opts("FzfLua live_grep"))
        vim.keymap.set("n", "<leader>fo", ":FzfLua oldfiles<CR>", opts("FzfLua oldfiles"))

    end
}

return fzf_lua
