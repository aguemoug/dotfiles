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

-- general env function
shared.env = function(name)
  local is_inside = vim.fn['vimtex#env#is_inside'](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end
return {
  s(
    { trig = 'mcl', name = 'multicol', dscr = 'insert multi col' },
    fmta(

      [[ 

\begin{multicols}{2} % 2 columns
<>
   \columnbreak % Manual column break
<>
\end{multicols}

    ]],
      { i(1), i(0) }
    ),
    { condition = shared.in_text, show_condition = shared.in_text }
  ),

  s(
    { trig = 'sfig', name = 'insert figure', dscr = 'insert a figure' },
    fmta(

      [[ 
    \begin{center}
    \includegraphics[scale=1.0]{<>}
    \end{center}
    <>
    ]],
      { i(1), i(0) }
    ),
    { condition = shared.in_text, show_condition = shared.in_text }
  ),

  s(
    { trig = 'fig', name = 'insert figure', dscr = 'insert a figure' },
    fmta(

      [[ 
    \begin{figure}
    \centring
    \includegraphics[scale=1.0]{<>}
    \lable{<>}
    \caption{<>}
    \end{figure}
    ]],
      { i(1), rep(1), i(0) }
    ),
    { condition = shared.in_text, show_condition = shared.in_text }
  ),

  s(
    { trig = 'beg', name = 'begin/end', dscr = 'begin/end environment (generic)' },
    fmta(
      [[
    \begin{<>}
    <>
    \end{<>}
    ]],
      { i(1), i(0), rep(1) }
    ),
    { condition = shared.in_text, show_condition = shared.in_text }
  ),

  s(
    { trig = '-i', name = 'itemize', dscr = 'bullet points (itemize)' },
    fmta(
      [[ 
    \begin{itemize}
    \item <>
    \end{itemize}
    ]],
      { c(1, { i(0), sn(
        nil,
        fmta(
          [[
        [<>] <>
        ]],
          { i(1), i(0) }
        )
      ) }) }
    ),
    { condition = shared.in_text, show_condition = shared.in_text }
  ),

  s(
    { trig = '-q', name = '', dscr = 'begin questions' },
    fmta(
      [[ 
    \begin{questions}
    <>
    \end{questions}
    ]],
      { i(0) }
    ),
    { condition = shared.in_text, show_condition = shared.in_text }
  ),

  s(
    { trig = '-ccc', name = '', dscr = 'begin questions' },
    fmta(
      [[ 
    \begin{oneparchoices}
    <>
    \end{oneparchoices}
    ]],
      { i(0) }
    ),
    { condition = shared.in_text, show_condition = shared.in_text }
  ),

  s(
    { trig = '-cbb', name = '', dscr = 'begin questions' },
    fmta(
      [[ 
    \begin{oneparcheckboxes}
    <>
    \end{oneparcheckboxes}
    ]],
      { i(0) }
    ),
    { condition = shared.in_text, show_condition = shared.in_text }
  ),

  s(
    { trig = '-cb', name = '', dscr = 'begin questions' },
    fmta(
      [[ 
    \begin{checkboxes}
    <>
    \end{checkboxes}
    ]],
      { i(0) }
    ),
    { condition = shared.in_text, show_condition = shared.in_text }
  ),

  s(
    { trig = '-cc', name = '', dscr = 'begin questions' },
    fmta(
      [[ 
    \begin{choices}
    <>
    \end{choices}
    ]],
      { i(0) }
    ),
    { condition = shared.in_text, show_condition = shared.in_text }
  ),

  s(
    { trig = '-s', name = 'souloution', dscr = 'insert souloution' },
    fmta(
      [[ 
    \begin{solution}
    \item <>
    \end{solution}
    ]],
      { c(1, { i(0), sn(
        nil,
        fmta(
          [[
        [<>] <>
        ]],
          { i(1), i(0) }
        )
      ) }) }
    ),
    { condition = shared.in_text, show_condition = shared.in_text }
  ),

  -- requires enumitem
  s(
    { trig = '-e', name = 'enumerate', dscr = 'numbered list (enumerate)' },
    fmta(
      [[ 
    \begin{enumerate}<>
    \item <>
    \end{enumerate}
    ]],
      {
        c(1, {
          t '',
          sn(
            nil,
            fmta(
              [[
        [label=<>]
        ]],
              { c(1, { t '(\\alph*)', t '(\\roman*)', i(1) }) }
            )
          ),
        }),
        c(2, { i(0), sn(
          nil,
          fmta(
            [[
        [<>] <>
        ]],
            { i(1), i(0) }
          )
        ) }),
      }
    ),
    { condition = shared.in_text, show_condition = shared.in_text }
  ),

  -- generate new bullet points
  autosnippet({ trig = '--', hidden = true }, {
    f(function(_, snip)
      if shared.in_multichoice() then
        return '\\choice'
      end
      if shared.env 'questions' then
        return '\\question'
      end
      if shared.env 'itemize' then
        return '\\item'
      end
    end, {}),
  }, { condition = shared.in_multi * shared.line_begin, show_condition = shared.in_multi }),

  autosnippet({ trig = '++', hidden = true }, {
    f(function(_, snip)
      if shared.in_multichoice() then
        return '\\CorrectChoice'
      end
    end, {}),
  }, { condition = shared.in_multi * shared.line_begin, show_condition = shared.in_multi }),
}
