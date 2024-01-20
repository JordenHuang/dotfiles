local nvim_tree = {
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

                -- my own function
                local function info(t)
                    -- filewrite = io.open("tempfile.txt", "a")
                    for k, v in pairs(t) do
                        if v then
                            -- print(string.format("%s: %s  ", k, v))
                            -- filewrite:write(string.format("%s: %s\n", k, v))
                            print(t['type'])
                        end
                    end
                    -- filewrite:write("\n")
                    -- filewrite:close()
                end

                local function cr_behavior(t)
                    if t['type'] == 'file' then 
                        api.node.open.edit()
                        api.tree.close()
                    else
                        api.node.open.edit()
                    end
                end


                -- default mappings
                -- api.config.mappings.default_on_attach(bufnr)

                -- custom mappings
                vim.keymap.set('n', "<CR>",           function() cr_behavior(api.tree.get_node_under_cursor()) end,         opts("Open and close nvim-tree"))
                vim.keymap.set('n', 'o',              api.node.open.edit,         opts("Open"))
                vim.keymap.set('n', "<Tab>",          api.node.open.preview,      opts("Open preview"))
                vim.keymap.set('n', "v",              api.node.open.vertical,     opts("Open vertical"))
                vim.keymap.set('n', "t",              api.node.open.tab,          opts("Open in new tab"))
                vim.keymap.set('n', 'c',              api.tree.collapse_all,      opts("Collapse"))
                vim.keymap.set('n', 'y',              api.fs.copy.filename,       opts("Copy File Name"))
                vim.keymap.set('n', 'r',              api.tree.reload,            opts("Show node info"))
                vim.keymap.set('n', 'i',              function() api.node.show_info_popup() info(api.tree.get_node_under_cursor()) end,   opts("Show node info"))
                vim.keymap.set('n', '<',              api.tree.change_root_to_parent,       opts("Up"))
                vim.keymap.set('n', '>',              api.tree.change_root_to_node,         opts("CD"))


                vim.keymap.set('n', '<C-h>',          ":h nvim-tree <CR>",        opts("Help"))
                vim.keymap.set('n', '<C-n>',          api.fs.create,              opts("Create File Or Directory"))
                vim.keymap.set('n', '<C-r>',          api.fs.rename,              opts("Rename"))
                vim.keymap.set('n', '<C-y>',          api.fs.copy.node,           opts("Copy"))
                vim.keymap.set('n', '<C-p>',          api.fs.paste,               opts("Paste"))
                vim.keymap.set('n', '<C-x>',          api.fs.cut,                 opts("Cut"))

                vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,         opts("Open"))
                vim.keymap.set('n', '<2-RightMouse>', api.node.open.edit,         opts("CD"))
            end
        }
    end,
}


local nvim_treesitter = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
        local install = require("nvim-treesitter.install")
        install.compilers = { "clang" }

        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html",
                "python", "cpp", "markdown", "yaml"
            },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },  
    })
end
}


return {
    nvim_tree,
    nvim_treesitter
}
