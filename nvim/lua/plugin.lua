local M  = {}

local function spec(path)
    path = "plugins." .. path
    local status, plugin = pcall(require, path)
    if not status then
        print(string.format("[ERROR] plugin: %s", plugin))
    else
        table.insert(M, plugin)
    end
end

--===== Plugins =====
spec("alpha_nvim")
spec("catppuccin-theme")
spec("cmp")
spec("colorizer")
spec("comment")
spec("fzf_lua")
spec("lua_line")
spec("nvim_tree")
spec("todo_highlight")
spec("treesitter")
spec("which_key")
spec("yazi")

-- Language server
-- spec("lsp.mason")
-- spec("lsp.nvim_lsp")

spec("como")

--===== Unused plugins =====
-- spec("oil_nvim")
-- spec("telescope")

-- Return to lazynvim.lua
return M
