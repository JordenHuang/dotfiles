-- telescope path display
vim.api.nvim_create_autocmd("FileType", {
    pattern = "TelescopeResults",
    callback = function(ctx)
        vim.api.nvim_buf_call(ctx.buf, function()
            vim.fn.matchadd("TelescopeParent", "\t\t.*$")
            vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
        end)
    end,
})

local function filenameFirst(_, path)
    local tail = vim.fs.basename(path)
    local parent = vim.fs.dirname(path)
    if parent == "." then
        return tail
    end
    return string.format("%s\t\t%s", tail, parent)
end


local nvim_telescope = {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()
        require("telescope").setup {
            defaults = {
                --preview = false,
                preview = {
                    filesize_limit = 20, -- MB
                },
                sorting_strategy = "ascending",
                path_display = filenameFirst,
                file_encoding = "utf-8",
                wrap = true,
            },
        }

        local function opts(description)
            return { desc = description, noremap = true, silent = true }
        end
        -- Nvim-telescope keymap
        vim.keymap.set('n', '<leader>ff', ":Telescope find_files<CR>", opts("Telescope find file"))
        vim.keymap.set('n', '<leader>fb', ":Telescope buffers initial_mode=normal<CR>", opts("Telescope buffers"))
        vim.keymap.set('n', '<leader>fl', ":Telescope live_grep<CR>", opts("Telescope live grep"))
        vim.keymap.set('n', '<leader>fh', ":Telescope help_tags<CR>", opts("Telescope help tags"))
        vim.keymap.set('n', '<leader>fk', ":Telescope keymaps initial_mode=normal<CR>", opts("Telescope show keymaps"))
        vim.keymap.set('n', '<leader>fm', ":Telescope marks initial_mode=normal<CR>", opts("Telescope show marks"))
        vim.keymap.set('n', '<leader>fo', ":Telescope oldfiles initial_mode=normal<CR>", opts("Telescope show old files"))
    end
}




return {
    nvim_telescope
}
