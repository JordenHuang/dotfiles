local nvim_treesitter = {
    "nvim-treesitter/nvim-treesitter",
    tag = "v0.9.2",
    build = ":TSUpdate",
    config = function ()
        local install = require("nvim-treesitter.install")
        install.compilers = { "clang", "gcc" }

        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "c", "lua", "vim", "vimdoc", "query",
                "javascript", "html", "python", "cpp", "markdown", "yaml", "toml", "bash"
            },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
    })
end
}


return {
    nvim_treesitter
}
