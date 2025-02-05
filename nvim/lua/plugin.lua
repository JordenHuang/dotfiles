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
spec("cmp")
spec("colorizer")
spec("comment")
spec("lua_line")
spec("nvim_tree")
spec("telescope")
spec("treesitter")
spec("which_key")

spec("lsp.mason")
spec("lsp.nvim_lsp")

spec("como")
spec("todo_highlight")


--===== Unused plugins =====
-- spec("oil_nvim")

-- Return to lazynvim.lua
return M
