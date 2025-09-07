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

  -- Box
  s("box", {
    d(1, function(args)
      local content = args[1][1]
      return {
        t("┌" .. string.rep("─", #content + 2) .. "┐")
      }
    end, { 1 }),
    t("│ "),
    i(1, ""),
    t(" │"),
    d(1, function(args)
      local content = args[1][1]
      return {
        t("└" .. string.rep("─", #content + 2) .. "┘")
      }
    end, { 1 }),
    i(0),
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
    t(".\\ ] "),
    i(0),
  }, {
    trig_type = "auto_expand",
    word_triggers = true,
  }),

  -- Subscripts
  s({ trig = "([A-Za-z])(\\d)", name = "auto subscript", dscr = "Auto subscript" }, {
    f(function(args)
      return args[1][1] .. "_" .. args[2][1]
    end, { 1, 2 }),
  }, {
    trig_type = "auto_expand",
    reg_exp = true,
  }),

  s({ trig = "([A-Za-z])_(\\d\\d)", name = "auto subscript2", dscr = "Auto subscript" }, {
    f(function(args)
      return args[1][1] .. "_{" .. args[2][1] .. "}"
    end, { 1, 2 }),
  }, {
    trig_type = "auto_expand",
    reg_exp = true,
  }),

  -- Superscripts
  s({ trig = "sr", name = "^2" }, { t("^2") }, { trig_type = "auto_expand", }),
  s({ trig = "cb", name = "^3" }, { t("^3") }, { trig_type = "auto_expand", }),
  s({ trig = "compl", name = "complement" }, { t("^{c}") }, { trig_type = "auto_expand", }),
  s({ trig = "td", name = "superscript" }, { t("^{"), i(1), t("}"), i(0) }, { trig_type = "auto_expand", }),

  -- Fractions
  s({ trig = "//", name = "Fraction" }, { t("\\frac{"), i(1), t("}{"), i(2), t("}"), i(0) }, { trig_type = "auto_expand", }),

  -- Regex Fraction
  s({ trig = "((\\d+)|(\\d*)(\\?)?([A-Za-z]+)((\\^|_)(\\{\\d+\\}|\\d))*)\\/", name = "Fraction" }, {
    f(function(args)
      return "\\frac{" .. args[1][1] .. "}{"
    end, { 1 }),
    i(1),
    t("}"),
    i(0),
  }, {
    trig_type = "auto_expand",
    reg_exp = true,
  }),

  -- Parenthesis Fraction
  s({ trig = "^.*\\)/", name = "() Fraction" }, {
    f(function(args, snip)
      local stripped = args.match[0]:sub(1, -2)
      local depth = 0
      local i = #stripped
      while true do
        if stripped:sub(i, i) == ')' then depth = depth + 1 end
        if stripped:sub(i, i) == '(' then depth = depth - 1 end
        if depth == 0 then break end
        i = i - 1
      end
      return stripped:sub(1, i - 1) .. "\\frac{" .. stripped:sub(i + 1, -1) .. "}"
    end, {}),
    i(1),
    i(0),
  }, {
    trig_type = "auto_expand",
    reg_exp = true,
    priority = 1000,
  }),

  -- Visual Fraction
  s({ trig = "/", name = "Visual Fraction", dscr = "Fraction from visual selection" }, {
    t("\\frac{"),
    f(function() return vim.fn.getreg('"') end, {}),
    t("}{"),
    i(1),
    t("}"),
    i(0),
  }),
}
