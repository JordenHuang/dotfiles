return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup {
            on_attach = function(bufnr)
                local api = require "nvim-tree.api"

                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                -- default mappings
                -- api.config.mappings.default_on_attach(bufnr)

                -- custom mappings
                vim.keymap.set('n', "<CR>",           api.node.open.edit,         opts("Open"))
                vim.keymap.set('n', "<Tab>",          api.node.open.preview,      opts("Open Preview"))
                vim.keymap.set('n', "v",              api.node.open.vertical,     opts('Open Preview'))
                vim.keymap.set('n', 'c',              api.tree.collapse_all,      opts('Collapse'))
                vim.keymap.set('n', 'y',              api.fs.copy.filename,       opts('Copy File Name'))
                vim.keymap.set('n', 'o',              api.node.open.edit,         opts('Open'))
                vim.keymap.set('n', '<',              api.tree.change_root_to_parent,       opts('Up'))
                vim.keymap.set('n', '>',              api.tree.change_root_to_node,         opts('CD'))


                vim.keymap.set('n', '<C-h>',          ":h nvim-tree <CR>",       opts('Help'))
                vim.keymap.set('n', '<C-n>',          api.fs.create,              opts('Create File Or Directory'))
                vim.keymap.set('n', '<C-r>',          api.fs.rename,              opts('Rename'))
                vim.keymap.set('n', '<C-y>',          api.fs.copy.node,           opts('Copy'))
                vim.keymap.set('n', '<C-p>',          api.fs.paste,               opts('Paste'))
                vim.keymap.set('n', '<C-x>',          api.fs.cut,                 opts('Cut'))
                
                vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,         opts('Open'))
                vim.keymap.set('n', '<2-RightMouse>', api.node.open.edit,         opts('CD'))
            end
        }
    end,
}
