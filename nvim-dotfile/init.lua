-- my neovim configure options
local my_options = {
	number = true,
	relativenumber = true,

	expandtab = true,
	tabstop = 4,
	smarttab = true,
	softtabstop = 4,
    shiftwidth = 4,
    autoindent = true,

    cursorline = true,

    wrap = false,
    scrolloff = 10,

	mouse = a,

    splitbelow = true,
    splitright = true,
    
	clipboard = "unnamedplus",
    
    virtualedit = "block",

    inccommand = "split",

    ignorecase = true,

    termguicolors = true,
}

for k, v in pairs(my_options) do
	vim.opt[k] = v 
end


-- keymaps
require("keymaps")

-- package manager: lazynvim
require("lazynvim-init")
