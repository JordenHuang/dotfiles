local which_key = {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 1250
    end,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    }
}


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
                preview = {
                    filesize_limit = 20, -- MB
                },
                path_display = filenameFirst,
                file_encoding = "utf-8",
                wrap = true,
            }
        }
    end
}


local nvim_cmp = {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
    },

    config = function()
        local cmp = require("cmp")
        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = cmp.mapping({
                    i = cmp.mapping.select_next_item(),
                    c = cmp.mapping.select_next_item(),
                }),
                ["<S-Tab>"] = cmp.mapping({
                    i = cmp.mapping.select_prev_item(),
                    c = cmp.mapping.select_prev_item(),
                }),
                ["<Esc>"] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = function()
                        if cmp.visible() then
                            cmp.close()
                        else
                            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-c>', true, true, true), 'n', true)
                        end
                    end
                }),
                ['<CR>'] = cmp.mapping({
                    i = function(fallback)
                        local entry = cmp.get_selected_entry()
                        if cmp.visible() and entry ~= nil then
                            cmp.confirm({ 
                                select = false,
                                behavior = cmp.ConfirmBehavior.Insert
                            })
                        else
                            fallback() -- If you use vim-endwise, this fallback will behave the same as vim-endwise.
                        end
                    end,
                    c = function(fallback)
                        local entry = cmp.get_selected_entry()
                        -- print(entry)
                        if cmp.visible() and entry ~= nil then
                            cmp.confirm({ 
                                select = true,
                                behavior = cmp.ConfirmBehavior.Insert
                            })
                        else
                            fallback() -- If you use vim-endwise, this fallback will behave the same as vim-endwise.
                        end
                    end,
                }),

                -- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                -- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                -- ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                -- ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
            }),

            sources = {
                { name = "buffer" },
                { name = 'path' },
                -- { name = "cmdline" },
            },
            -- confirm_opts = {
            --     behavior = cmp.ConfirmBehavior.Replace,
            --     select = false,
            -- },
        })

        -- Use buffer source for '/'.
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline();
            sources = {
                { name = 'buffer' }
            }
        })

        -- Use cmdline & path source for ':'.
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline();
            sources = cmp.config.sources(
                {
                    { name = 'path' }
                }, 
                {
                    { name = 'cmdline' }
                }
            )
        })
    end
}


return {
    which_key,
    nvim_telescope,
    nvim_cmp
}
