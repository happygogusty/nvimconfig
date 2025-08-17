local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"sainnhe/sonokai",
        lazy = false,
        priority =1000,
		config = function()
            vim.g.sonokai_enable_italic = true
            vim.g.sonokai_style = 'espresso'
            vim.g.sonokai_transparent_background = '1'
			vim.cmd.colorscheme("sonokai")
		end,
	},
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {"c", "lua", "vim", "vimdoc", "query", "markdown", "python", "latex"},

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
        end,
    },
    {
		"lervag/vimtex",
  		lazy = false,
  		init = function()
    		vim.g.vimtex_view_method = "zathura"
  		end
    },
    {
        'neoclide/coc.nvim', branch = 'release', 
    },
    {
        'vimwiki/vimwiki',
        init = function()
            vim.g.vimwiki_list = {
                {
                path = '/home/yaja/Documents/vimwiki',
                syntax = 'markdown',
                ext = '.md',
                }
            }
        end
    }
})


