return {
    {
        "folke/tokyonight.nvim",
        opts = {
            style = "night",
            on_highlights = function(hl, c)
                hl.LineNr = { fg = c.white }
                hl.CursorLineNr = { fg = c.orange }
            end,
        },
    },
}
