local nvim_cmp = {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
    },

    config = function()
        local cmp = require("cmp")
        local confirm_opts = {
            select = true,
            behavior = cmp.ConfirmBehavior.Insert,
        }
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
                    i = function(fallback)
                        local entry = cmp.get_active_entry()
                        if cmp.visible() and entry ~= nil then
                            cmp.abort()
                        else 
                            fallback()
                        end
                    end,

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
                        local entry = cmp.get_active_entry()
                        -- local entries = cmp.get_entries()
                        if cmp.visible() and entry ~= nil then
                            cmp.confirm(confirm_opts)
                        else
                            fallback() -- If you use vim-endwise, this fallback will behave the same as vim-endwise.
                        end
                    end,
                    c = function(fallback)
                        local entry = cmp.get_active_entry()
                        -- print(entry)
                        if cmp.visible() and entry ~= nil then
                            cmp.confirm(confirm_opts)
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
    nvim_cmp
}
