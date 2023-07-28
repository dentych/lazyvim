return {
    {
        "folke/tokyonight.nvim",
        opts = {
            style = "night",
            on_highlights = function(hl, c)
                hl.LineNr = { fg = c.green }
                hl.CursorLineNr = { fg = c.orange }
                hl.Comment = { fg = "#cccccc" }
            end,
        },
    },
}
