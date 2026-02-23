local mason = {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
        require("mason").setup()
    end
}
local mason_lsp = {
    "williamboman/mason-lspconfig.nvim",
    tag = "v1.32.0",
    lazy = false,
    --opts = {
    --    auto_install = true,
    --},
}


return {
    mason,
    mason_lsp
}
