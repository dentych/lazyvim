return {
    "github/copilot.vim",
    event = "BufEnter",
    keys = {
        { "<C-z>", "<Plug>(copilot-dismiss)", mode = "i"},
        { "<C-f>", "<Plug>(copilot-accept-word)", mode = "i"},
        { "<C-l>", "<Plug>(copilot-accept-line)", mode = "i"},
        { "<C-e>", "<Plug>(copilot-next)", mode = "i"},
        { "<C-q>", "<Plug>(copilot-previous)", mode = "i"},
    },
}
