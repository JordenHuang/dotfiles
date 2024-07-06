-- Options
require("options")

-- Keymaps
require("keymaps")

-- Package manager: lazynvim
require("lazynvim")

-- my scripts
require("my_scripts.utils").setup()
-- require("my_scripts.qftf-custom")

-- vim.cmd("edit .")


-- require("my_scripts.test").setup()
-- require("my_scripts.test2").setup()
-- require("my_scripts.test3").setup()

-- my_func = function (cmd)
--     local output = vim.fn.system(cmd)
--     print(output)
-- end
