local nvim_cmp = {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-nvim-lua",
    },

    config = function()
        local cmp = require("cmp")
        local confirm_opts = {
            select = false, -- Don't automatically select the first item when there's no selection by the user
            behavior = cmp.ConfirmBehavior.Insert,
        }

        cmp.setup({
            completion = {
                -- Disable automatically activating
                autocomplete = false,
            },
            window = {
                completion = { -- rounded border; thin-style scrollbar
                    border = 'rounded',
                    scrollbar = '║',
                },
                documentation = { -- no border; native-style scrollbar
                    border = nil,
                    scrollbar = '',
                },
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                ["<Esc>"] = cmp.mapping({
                    c = function()
                        if cmp.visible() then
                            cmp.close()
                        else
                            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-c>', true, true, true), 'n', true)
                        end
                    end
                }),

                ['<CR>'] = function(fallback)
                    if cmp.visible() then
                        cmp.confirm()
                    else
                        fallback() -- If you use vim-endwise, this fallback will behave the same as vim-endwise.
                    end
                end,

                ["<C-Space>"] = cmp.mapping(cmp.mapping.complete({
                    reason = cmp.ContextReason.Auto,
                }), { "i" }),

                ['<C-l>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        return cmp.complete_common_string()
                    end
                    fallback()
                end, { 'i', 'c' }),
            }),

            sources = {
                {
                    name = 'buffer',
                    option = {
                        get_bufnrs = function()
                            -- USE SOURCES IN ALL OPENED BUFFERS
                            return vim.api.nvim_list_bufs()
                            -- USE SOURCES ONLY IN OPENED WINDOWS
                            -- local bufs = {}
                            -- for _, win in ipairs(vim.api.nvim_list_wins()) do
                            --     bufs[vim.api.nvim_win_get_buf(win)] = true
                            -- end
                            -- return vim.tbl_keys(bufs)
                        end
                    }
                },
                { name = 'nvim_lsp' },
                { name = 'path' },
                { name = "nvim_lua" },
            },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end
            },
        })

        -- Use buffer source for '/'.
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- Use cmdline & path source for ':'.
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            -- mapping = cmp.mapping.preset.cmdline({
            --     ["<C-n>"] = cmp.mapping({ c = function(fallback) fallback() end }),
            --     ["<C-p>"] = cmp.mapping({ c = function(fallback) fallback() end }),
            -- }),
            sources = cmp.config.sources(
                {
                    { name = 'path' }
                },
                {
                    { name = 'cmdline' }
                }
            ),
            -- enabled = function()
            --     -- Set of commands where cmp will be disabled
            --     local disabled = {
            --         -- IncRename = true
            --         -- cexpr = true
            --     }
            --     -- Get first word of cmdline
            --     local cmd = vim.fn.getcmdline():match("%S+")
            --     -- Return true if cmd isn't disabled
            --     -- else call/return cmp.close(), which returns false
            --     return not disabled[cmd] or cmp.close()
            -- end
        })

        -- Use cmdline & path source for '@', used in vim.ui.input()
        cmp.setup.cmdline('@', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'path' },
            }
        })
    end
}

return {
    nvim_cmp
}
