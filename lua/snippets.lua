local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local f = ls.function_node
local c = ls.choice_node
local rep = require("luasnip.extras").rep

return {
  -- Date
  s("today", {
    f(function()
      return os.date("%m-%d-%Y")
    end, {}),
  }),
    

  -- Environment
  s({ trig = "beg", name = "begin{} / end{}", dscr = "LaTeX environment" }, {
    t("\\begin{"),
    i(1),
    t("}"),
    t(""),
    i(0),
    t(""),
    t("\\end{"),
    rep(1),
    t("}"),
  }, {
    trig_type = "auto_expand",
    b = true,
  }),

  -- Inline Math
  s({ trig = "mk", name = "Math", dscr = "Inline math" }, {
    t("$"),
    i(1),
    t("$"),
    f(function()
      local next_char = vim.fn.getline('.')[vim.fn.col('.') - 1]
      if next_char and not next_char:match("['\",.?!\\- ]") then
        return " "
      else
        return ""
      end
    end, {}),
    i(0),
  }, {
    trig_type = "auto_expand",
    word_triggers = true,
  }),

  -- Displayed Math
  s({ trig = "dm", name = "Math", dscr = "Displayed math" }, {
    t("\\["),
    i(1),
    t(""),
    t("\\ ] "),
    i(0),
  }, {
    trig_type = "auto_expand",
    word_triggers = true,
  }),
 
  -- Superscripts
  s({ trig = "sr", name = "^2" }, { t("^2") }, { trig_type = "auto_expand", }),
  s({ trig = "cb", name = "^3" }, { t("^3") }, { trig_type = "auto_expand", }),
  s({ trig = "compl", name = "complement" }, { t("^{c}") }, { trig_type = "auto_expand", }),
  s({ trig = "td", name = "superscript" }, { t("^{"), i(1), t("}"), i(0) }, { trig_type = "auto_expand", }),
  
  -- Fractions
  s({ trig = "//", name = "Fraction" }, { t("\\frac{"), i(1), t("}{"), i(2), t("}"), i(0) }, { trig_type = "auto_expand", }),

-- Matrix
  s({ trig = "mat", name = "Matrix", dscr = "Creates a matrix environment" }, {
    t("\\begin{pmatrix}"),
    t(""),
    i(1, ""), t(" & "), i(2, ""),
    t(""),
    t("\\end{pmatrix}"),
  }),
  
  -- Arrows
  s("larr", {
    t("\\leftarrow")
  }),
  s("rarr", {
    t("\\rightarrow")
  }),
  s("harr", {
    t("\\leftrightarrow")
  }),

  -- Vector
  s({ trig = "vec", name = "Vector", dscr = "Bold character with arrow" }, {
    t("\\vec{\\mathbf{"),
    i(1),
    t("}}"),
  }),
}


