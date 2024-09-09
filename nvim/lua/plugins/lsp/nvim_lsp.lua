-- Thanks to the author of https://github.com/deniserdogan/dotfiles

local nvim_lsp_config = {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
        local override = {
            snippetSupport = false,
            deprecatedSupport = false,
        }
        local capabilities = require("cmp_nvim_lsp").default_capabilities(override)

        local lspconfig = require("lspconfig")

        -- rust language server
        lspconfig.rust_analyzer.setup({
            capabilities = capabilities,
            filetypes = {"rust"},
            settings = {
                ["rust-analyzer"] = {
                    diagnostics = {
                        enable = true,
                        disabled = {"unlinked-file"}
                    }
                }
            }
        })

        -- assembly language server
        lspconfig.asm_lsp.setup({
            capabilities = capabilities,
        })

        lspconfig.clangd.setup({
            capabilities = capabilities,
        })

        -- lua language server
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME,
                        },
                    },
                    hint = {
                        enable = true,
                    },
                },
            },
        })

        -- Disable the diagnostic because it's annoying
        -- vim.diagnostic.disable()


        local function opts(description)
            return { desc = description, noremap = true, silent = true }
        end
        vim.keymap.set("n", "<leader>K",  vim.lsp.buf.hover,            opts("LSP: Displays hover information about the symbol"))
        vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename,           opts("LSP: Renames all references to the symbol"))
        vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition,  opts("LSP: Jumps to the definition of the type of the symbol"))
        vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation,   opts("LSP: Lists all the implementations for the symbol in the quickfix window"))
        vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition,       opts("LSP: Jumps to the definition of the symbol"))
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references,       opts("LSP: Lists all the references to the symbol"))
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action,      opts("LSP: Selects a code action available"))

        -- Errors
        vim.keymap.set("n", "<leader>lf", vim.diagnostic.open_float,    opts("diagnostic open float"))
        vim.keymap.set("n", "<leader>l]", vim.diagnostic.goto_next,     opts("diagnostic goto next"))
        vim.keymap.set("n", "<leader>l[", vim.diagnostic.goto_prev,     opts("diagnostic goto prev"))
        vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", opts("Telescope diagnostics"))
    end
}

return {
    nvim_lsp_config
}
