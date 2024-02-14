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
    scrolloff = 3,

	mouse = a,

    splitbelow = true,
    splitright = true,
    
    encoding = "utf-8",
	clipboard = "unnamedplus",
    
    virtualedit = "block",

    completeopt = { "menu", "menuone", "noselect" },

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

-- set background base on time of day
--local hour = os.date("*t").hour
--if hour >= 5 and hour < 19 then
--    vim.opt.background = "light"
--else
--    vim.opt.background = "dark"
--end
