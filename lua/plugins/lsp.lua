return {
    {
        "williamboman/mason.nvim",
        keys = {
            { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
        }
    },
    {
        "williamboman/mason-lspconfig.nvim",
    },
    {
        "neovim/nvim-lspconfig",
        event = "VimEnter",
        dependencies = {
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function(_, opts)
            -- setup lagnuage server stuff
            require("mason").setup(opts)
            require("mason-lspconfig").setup(opts)
            require("mason-lspconfig").setup_handlers {
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {}
                end,
                -- Next, you can provide a dedicated handler for specific servers.
                -- For example, a handler override for the `rust_analyzer`:
                ["rust_analyzer"] = function()
                    require("rust-tools").setup {}
                end,
                ["gopls"] = function()
                    require("lspconfig").gopls.setup({
                        settings = {
                            gopls = {
                                buildFlags = {"-tags=integration"},
                            }
                        }
                    })
                end
            }


            -- setup keys
            local builtin = require("telescope.builtin")
            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set('n', '<space>df', vim.diagnostic.open_float)
            vim.keymap.set('n', '[e', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']e', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<space>dl', vim.diagnostic.setloclist)

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    local util = require("util")
                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
                        require("util").merge(opts, { desc = "Go to declaration" }))
                    vim.keymap.set('n', 'gd', function() builtin.lsp_definitions() end, { desc = "Go to definition" })
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show hover" })
                    vim.keymap.set('n', 'gi', function() builtin.lsp_implementations() end,
                        { desc = "Go to implementation" })
                    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { desc = "Signature help" })
                    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
                    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder,
                        { desc = "Remove workspace folder" })
                    vim.keymap.set('n', '<space>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, { desc = "List workspace folders" })
                    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<space>cr', vim.lsp.buf.rename, { desc = "Rename" })
                    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, { desc = "Code action" })
                    vim.keymap.set('n', 'gr', function() builtin.lsp_references() end, { desc = "Go to reference" })
                    vim.keymap.set('n', '<space>cf', function()
                        vim.lsp.buf.format { async = true }
                    end, { desc = "Format code" })
                end,
            })
        end
    },
}
