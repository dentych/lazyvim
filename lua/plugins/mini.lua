return {
    { 
        'echasnovski/mini.nvim', version = '*',
        config = function()
            require("mini.surround").setup()
            require("mini.pairs").setup()
            require("mini.comment").setup()
            require("mini.bufremove").setup()
            require("mini.ai").setup()
            require("mini.indentscope").setup()
        end,
    },
}
