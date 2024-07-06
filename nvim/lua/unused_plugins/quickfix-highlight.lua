local quickfix_highlight = {
    'yorickpeterse/nvim-pqf',
    config = function()
        require('pqf').setup()
    end
}

return {
    quickfix_highlight
}
