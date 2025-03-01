local M  = {}

local function spec(path)
    path = "plugins." .. path
    local status, plugin = pcall(require, path)
    if not status then
        print(string.format("Some ERROR occurs, plugin: %s", plugin))
    else
        table.insert(M, plugin)
    end
end

--===== Plugins =====
spec("alpha_nvim")
spec("catppuccin-theme")
spec("colorizer")
spec("comment")
spec("lua_line")
spec("nvim_tree")
spec("oil_nvim")
spec("telescope")
spec("treesitter")
spec("todo_highlight")
spec("which_key")

-- Language server
-- spec("lsp.mason")
-- spec("lsp.nvim_lsp")

spec("como")

--===== Unused plugins =====
-- spec("cmp")

-- Return to lazynvim.lua
return M
