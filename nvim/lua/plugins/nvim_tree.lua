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

                -- Functions
                local function log_info(t)
                    -- filewrite = io.open("tempfile.txt", "a")
                    for _, v in pairs(t) do
                        if v then
                            -- print(string.format("%s: %s  ", k, v))
                            -- filewrite:write(string.format("%s: %s\n", k, v))
                            print("It's a " .. t['type'])
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

                local function change_root_to_global_cwd()
                    local global_cwd = vim.fn.getcwd(-1, -1)
                    print(global_cwd)
                    api.tree.change_root(global_cwd)
                end

                local function change_root_to_current_buffer_dir()
                    local lastused_buf_time_stamp = 0
                    local lastused_buf_nr = -1
                    local tree_buf = vim.fn.bufnr('%')

                    for _, buf_nr in ipairs(vim.api.nvim_list_bufs()) do
                        local cur_time_stamp = vim.fn.getbufinfo(buf_nr)[1].lastused
                        -- Find the biggest time stamp -> most recently used buffer
                        if lastused_buf_time_stamp < cur_time_stamp and buf_nr ~= tree_buf then
                            lastused_buf_time_stamp = cur_time_stamp
                            lastused_buf_nr = buf_nr
                        end
                    end
                    if lastused_buf_nr == -1 then
                        print("No last used buffer")
                        return
                    end

                    --for i, v in ipairs(vim.fn.getbufinfo(last_buf_nr)) do
                    --    for j, k in pairs(v) do
                    --        print(j, k)
                    --    end
                    --end

                    local last_buf_path = vim.fn.getbufinfo(lastused_buf_nr)[1].name
                    -- print(last_buf_path)
                    -- local a, b, c = string.match(last_buf_path, "(.-)([^\\/]-%.?([^%.\\/]*))$")
                    -- print(a, b, c)
                    -- local last_buf_dir = string.match(last_buf_path, "(.-)[^\\/]-$")

                    local last_buf_dir = vim.fn.fnamemodify(last_buf_path, ":p:h")
                    print(last_buf_dir)
                    api.tree.change_root(last_buf_dir)
                end


                -- default mappings when on attach
                -- api.config.mappings.default_on_attach(bufnr)

                -- custom mappings
                vim.keymap.set('n', '<F1>',  api.tree.toggle_help,                 opts('Help'))
                vim.keymap.set('n', 'o',     api.node.open.edit,                   opts("Open"))
                vim.keymap.set('n', "p",     api.node.open.preview,                opts("Open preview"))
                vim.keymap.set('n', "s",     api.node.open.horizontal,             opts("Open horizontal"))
                vim.keymap.set('n', "v",     api.node.open.vertical,               opts("Open vertical"))
                vim.keymap.set('n', "t",     api.node.open.tab,                    opts("Open in new tab"))
                vim.keymap.set('n', 'c',     api.tree.collapse_all,                opts("Collapse"))
                vim.keymap.set('n', 'y',     api.fs.copy.filename,                 opts("Copy File Name"))
                vim.keymap.set('n', 'r',     api.tree.reload,                      opts("Reload"))
                vim.keymap.set('n', '<',     api.tree.change_root_to_parent,       opts("Up"))
                vim.keymap.set('n', '-',     api.tree.change_root_to_parent,       opts("Up"))
                vim.keymap.set('n', '>',     api.tree.change_root_to_node,         opts("CD"))
                vim.keymap.set('n', 'f',     api.tree.change_root_to_node,         opts("CD"))
                vim.keymap.set('n', 'i',     function() api.node.show_info_popup() log_info(api.tree.get_node_under_cursor()) end, opts("Show node info"))
                vim.keymap.set('n', "<CR>",  function() cr_behavior(api.tree.get_node_under_cursor()) end, opts("Open file and close nvim-tree"))
                vim.keymap.set('n', 'd',     change_root_to_global_cwd,         opts('Change Root To Global CWD'))
                vim.keymap.set('n', 'b',     change_root_to_current_buffer_dir, opts('Change Root To current buffer dir'))


                vim.keymap.set('n', '<C-n>', api.fs.create,              opts("Create File Or Directory"))
                vim.keymap.set('n', '<C-r>', api.fs.rename,              opts("Rename"))
                vim.keymap.set('n', '<C-y>', api.fs.copy.node,           opts("Copy"))
                vim.keymap.set('n', '<C-p>', api.fs.paste,               opts("Paste"))
                vim.keymap.set('n', '<C-x>', api.fs.cut,                 opts("Cut"))

                vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,         opts("Open"))
                vim.keymap.set('n', '<2-RightMouse>', api.node.open.edit,         opts("CD"))
            end
        }


        -- Nvim-tree keymap
        vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "nvim-tree: Open nvim-tree", noremap = true, silent = true, nowait = true })
    end,
}


return {
    nvim_tree
}
