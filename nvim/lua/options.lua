-- my neovim configure options
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true

vim.opt.textwidth = 78

vim.opt.cursorline = true

vim.opt.listchars = { tab = "> ", trail = "·", nbsp = "+" }
vim.opt.list = true
--vim.cmd([[
--    set listchars=tab:>\ ,trail:·,nbsp:+
--    set list
--]])

vim.opt.wrap = true
vim.opt.linebreak = true

vim.opt.mouse = "a"

-- vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.encoding = "utf-8"
vim.opt.clipboard = "unnamedplus"

vim.opt.virtualedit = "block"

-- vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect", "preview" }

vim.opt.inccommand = "split"

vim.opt.ignorecase = false

vim.opt.termguicolors = true


-- Try below in Linux
-- vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver50,r-cr-o:hor20"
-- Use below in Windows
vim.opt.guicursor = "n-v-c-i-sm:block,i-ci-ve:blinkwait700-blinkoff400-blinkon250,r-cr-o:hor20"


vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
