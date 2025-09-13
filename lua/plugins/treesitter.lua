return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {"c", "html", "css", "javascript", "lua", "vim", "vimdoc", "query", "markdown", "python", "latex"},

            auto_install = true,

            highlights = {
                enable = true,
            },
            require'nvim-treesitter.configs'.setup {
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<Leader>ss",
                        node_incremental = "<Leader>si",
                        scope_incremental = "<Leader>sc",
                        node_decremental = "<Leader>sd",
                    },
                },
            }

        })
    end
}
