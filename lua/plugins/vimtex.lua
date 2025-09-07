return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    -- General Settings
    vim.g.tex_flavor = 'latex'
    
    -- Correct viewer method for Zathura with forward search
    vim.g.vimtex_view_method = "zathura"

    -- Quickfix and Conceal settings (these are fine)
    vim.g.vimtex_quickfix_mode = 0
    vim.g.vimtex_syntax_conceal_disable = 0
    vim.g.vimtex_syntax_conceal = {
      accents = 1,
      ligatures = 1,
      cites = 1,
      fancy = 1,
      spacing = 1,
      greek = 1,
      math_bounds = 1,
      math_delimiters = 1,
      math_fracs = 1,
      math_super_sub = 1,
      math_symbols = 1,
      sections = 1,
      styles = 1,
    }
    vim.g.tex_conceal = 'abdmg'
    
    -- Compiler settings (these are fine)
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
      callback = 1,
      continuous = 1,
      executable = "latexmk",
      options = {
        "-shell-escape",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
      },
    }
  end
}
