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
spec("catppuccin-theme")
spec("cmp")
spec("colorizer")
spec("nvim_tree") 
spec("lua_line")
--spec("feline")  -- require Neovim 0.9+
spec("telescope")
spec("terminal")
spec("treesitter")
spec("which_key")
spec("oil_nvim")
spec("alpha_nvim")

-- TODO: add cheatsheet.nvim


-- Return to lazynvim.lua
return M
