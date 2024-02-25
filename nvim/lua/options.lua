-- my neovim configure options
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true

vim.opt.cursorline = true

vim.opt.wrap = false
vim.opt.scrolloff = 3

vim.opt.mouse = "a"

vim.opt.splitbelow = true
vim.opt.splitright = true
    
vim.opt.encoding = "utf-8"
vim.opt.clipboard = "unnamedplus"
    
vim.opt.virtualedit = "block"

vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.opt.inccommand = "split"

vim.opt.ignorecase = true

vim.opt.termguicolors = true


-- Try below in Linux
--vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver50,r-cr-o:hor20"
-- Use below in Windows
vim.opt.guicursor = "n-v-c-i-sm:block,i-ci-ve:blinkwait700-blinkoff400-blinkon250,r-cr-o:hor20"
