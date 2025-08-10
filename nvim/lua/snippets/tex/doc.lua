-- ~/.config/nvim/lua/luasnip/tex/snippets.lua
--
--
--
local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require 'luasnip.util.events'
local ai = require 'luasnip.nodes.absolute_indexer'
local extras = require 'luasnip.extras'
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local conds = require 'luasnip.extras.expand_conditions'
local postfix = require('luasnip.extras.postfix').postfix
local types = require 'luasnip.util.types'
local parse = require('luasnip.util.parser').parse_snippet
local ms = ls.multi_snippet
local autosnippet = ls.extend_decorator.apply(s, { snippetType = 'autosnippet' })

local shared = require 'snippets.tex.shared'
-- Custom condition for new empty files
local is_new_empty_file = function()
  -- Check if buffer is empty
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local is_empty = #lines == 1

  -- Check if we haven't inserted this before
  local not_inserted = vim.b.examdoc_inserted ~= true

  return is_empty and not_inserted
end
return {

  s(
    { trig = 'examdoc', name = 'examdoc', dscr = 'new exam doc' },
    fmta(
      [[

\documentclass{msilaexam}
\setexamtitle{<>}
\setexamSubtitle{<>}
\setexamdate{<>}
\setexamduration{<>}
\begin{document}
\section{Exercise 01}

<>
\section{Exercise 02}

\section{Exercise 03}

\section{Exercise 04}

\end{document}
    ]],
      {
        i(1, 'document title'),
        i(2, 'subtitle'),
        i(3, 'date'),
        i(4, 'duration'),
        i(0),
      }
    ),
    {
      condition = function()
        return shared.in_preamble() and is_new_empty_file()
      end,
      show_condition = shared.in_preamble,
    }
  ),
}
