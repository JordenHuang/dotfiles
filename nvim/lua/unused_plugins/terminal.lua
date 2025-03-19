local nvim_toggleterm = {
    'akinsho/toggleterm.nvim', version = "*",
    opts = {
        --[[ things you want to change go here]]
    },

    config = function()
        if vim.o.shell == "cmd.exe" then
            local powershell_options = {
                shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
                shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
                shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
                shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
                shellquote = "",
                shellxquote = "",
            }
            for option, value in pairs(powershell_options) do
                vim.opt[option] = value
            end
        end

        require("toggleterm").setup({
            size = 12,
            open_mapping = "<leader>m",
            insert_mappings = false,
            hide_numbers = true,

            -- make terminal background darker
            shade_terminals = true,
            shading_factor = 1,

            start_in_insert = true,
            direction = "horizontal",
            shell = vim.o.shell,
            float_opts = {
                border = "curved",
                winblend = 0,
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
            },
        })

        local function opts(description)
            return { desc = description, noremap = true, silent = true }
        end
        -- Nvim-toggleterm keymap
        vim.keymap.set("n", "<leader>th",  ":ToggleTerm size=12 direction=horizontal name=terminal<CR>", opts("Toggleterm open horizontal"))
        vim.keymap.set("n", "<leader>tv",  ":ToggleTerm size=60 direction=vertical name=terminal<CR>",   opts("Toggleterm open vertical"))
        vim.keymap.set("n", "<leader>tf",  ":ToggleTerm size=20 direction=float name=terminal<CR>",      opts("Toggleterm open float"))
        -- vim.keymap.set("n", "<leader>tn",  ":TermExec cmd='echo %' size=12 direction=horizontal name=terminal<CR>", opts("Toggletrem open second terminal horizontally"))
        function _G.set_terminal_keymaps()
            local function opts(desc)
                return {desc = "Toggleterm: "..desc, buffer = 0}
            end

            vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts("leave terminal mode"))
            vim.keymap.set("t", "kj", "<C-\\><C-n>",    opts("leave terminal mode"))
            vim.keymap.set("t", "<leader>w", "<C-\\><C-n><C-w><C-w>",    opts("navigation of windows"))
        end

        -- if you only want these mappings for toggle term use term://*toggleterm#* instead
        vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

    end,
}


return{
    nvim_toggleterm
}
