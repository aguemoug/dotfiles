local M = {}

M.in_math = function()
  return vim.api.nvim_eval 'vimtex#syntax#in_mathzone()' == 1
end

-- comment detection
M.in_comment = function()
  return vim.fn['vimtex#syntax#in_comment']() == 1
end

-- document class
M.in_beamer = function()
  return vim.b.vimtex['documentclass'] == 'beamer'
end

-- general env function
M.env = function(name)
  local is_inside = vim.fn['vimtex#env#is_inside'](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end

M.in_preamble = function()
  return not M.env 'document'
end

M.in_text = function()
  return M.env 'document' and not M.in_math()
end

M.in_tikz = function()
  return M.env 'tikzpicture'
end

M.in_questions = function()
  return M.env 'questions'
end

M.in_multichoice = function()
  return M.env 'oneparchoices' or M.env 'choices' or M.env 'checkboxes' or M.env 'oneparcheckboxes'
end

M.in_multi = function()
  return (M.env 'itemize' or M.env 'enumerate' or M.env 'questions' or M.in_multichoice())
end

M.in_bullets = function()
  return M.env 'itemize' or M.env 'enumerate'
end

M.in_align = function()
  return M.env 'align' or M.env 'align*' or M.env 'aligned'
end

M.show_line_begin = function(line_to_cursor)
  return #line_to_cursor <= 3
end

-- local in_bullets_cond = make_condition(in_bullets)
M.make_condition = require('luasnip.extras.conditions').make_condition
M.line_begin = require('luasnip.extras.conditions.expand').line_begin

return M
