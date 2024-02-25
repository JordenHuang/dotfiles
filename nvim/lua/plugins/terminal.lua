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
    end,
}


return{
    nvim_toggleterm
}
