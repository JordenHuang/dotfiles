local M  = {}
local status, plugin
local flag = 0, filewrite

local function spec(path)
    path = "plugins." .. path
    status, plugin = pcall(require, path)
    if not status then
        if flag == 0 then
            flag = 1
            filewrite = io.open("log.txt", "a")
            filewrite:write(os.date() .. "\n")
        end
        filewrite:write(string.format("%s:\n%s\n", v, plugin))
    else
        table.insert(M, plugin)
    end
end

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


if flag == 1 then
    filewrite:write("\n-----\n")
    filewrite:close()
end


return M
