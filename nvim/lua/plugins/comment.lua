local comment = {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    opts = {
        -- add any options here
    },
    config = function ()
        require('Comment').setup({
            mappings = {
                ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                basic = true,
                ---Extra mapping; `gco`, `gcO`, `gcA`
                extra = false,
            },
        })
    end
}

return {
    comment
}
