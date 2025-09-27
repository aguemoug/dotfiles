local ls = require("luasnip")

local in_document_body_cache = nil
-- Shortcuts
local s, sn, isn, t, i, f, c, d, r =
	ls.snippet,
	ls.snippet_node,
	ls.indent_snippet_node,
	ls.text_node,
	ls.insert_node,
	ls.function_node,
	ls.choice_node,
	ls.dynamic_node,
	ls.restore_node

local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet

-- Extras
local extras = require("luasnip.extras")
local l, rep, p, m, n, dl =
	extras.lambda, extras.rep, extras.partial, extras.match, extras.nonempty, extras.dynamic_lambda

-- Format helpers
local fmt, fmta = require("luasnip.extras.fmt").fmt, require("luasnip.extras.fmt").fmta

-- Conditions & postfix
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local make_condition = require("luasnip.extras.conditions").make_condition
local line_begin = require("luasnip.extras.conditions.expand").line_begin

-- Autosnippet decorator
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

-- Vim API shortcuts
local fn, api, buf = vim.fn, vim.api, vim.b

-- Environment helpers
local function env(name)
	local inside = fn["vimtex#env#is_inside"](name)
	return inside[1] > 0 and inside[2] > 0
end

-- Core context checks
local function in_math()
	return api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end
local function in_comment()
	return fn["vimtex#syntax#in_comment"]() == 1
end
local function in_beamer()
	return buf.vimtex.documentclass == "beamer"
end
local function in_preamble()
	return not env("document")
end
local function in_text()
	return env("document") and not in_math()
end

local function in_document_body()
	if in_document_body_cache ~= nil then
		return in_document_body_cache
	end

	-- Case 1: Directly in main document
	if env("document") then
		return true
	end

	-- Case 2: In included file
	if vim.b.vimtex then
		local root_file = vim.b.vimtex.base
		local current_file = vim.fn.expand("%:t")
		if root_file == current_file then
			return false
		end

		-- Search root file for document context
		local lines = vim.fn.readfile(root_file)
		local in_preamble = true

		for _, line in ipairs(lines) do
			if line:match("\\begin{document}") then
				in_preamble = false
			elseif not in_preamble and line:match("\\input{" .. current_file:gsub("%.tex$", "") .. "}") then
				in_document_body_cache = true
				return true
			elseif not in_preamble and line:match("\\input{" .. current_file .. "}") then
				in_document_body_cache = true
				return true
			end
		end
	end
	return false
end
local function show_line_begin(line)
	return #line <= 3
end

-- Individual environment checks
local function in_tikz()
	return env("tikzpicture")
end

local function in_questions()
	return env("questions")
end

local function in_bullets()
	return env("itemize") or env("enumerate")
end

local function in_align()
	return env("align") or env("align*") or env("aligned")
end

local function in_multichoice()
	return env("oneparchoices") or env("choices") or env("checkboxes") or env("oneparcheckboxes")
end

-- Composite checks
local function in_multi()
	return in_multichoice() or in_questions() or in_bullets()
end

local function tex_snip(trig, name, dscr, fmt_str, nodes, opts)
	opts = vim.tbl_extend("force", { condition = in_document_body, show_condition = in_document_body }, opts or {})
	return s({ trig = trig, name = name, dscr = dscr }, fmta(fmt_str, nodes), opts)
end

-- Generic begin/end environment
local function env_snip(trig, env_name)
	return tex_snip(
		trig,
		env_name,
		"begin/end " .. env_name,
		[[
\begin{<>}
<>
\end{<>}
  ]],
		{ t(env_name), i(0), t(env_name) }
	)
end

-- Choices-like environments
local function choice_env_snip(trig, env_name)
	return env_snip(trig, env_name)
end

return {
	env_snip("-it", "itemize"),
	env_snip("-en", "enumerate"),
	env_snip("-eq", "equation"),
	choice_env_snip("-q", "questions"),
	choice_env_snip("-ccc", "oneparchoices"),
	choice_env_snip("-cbb", "oneparcheckboxes"),
	choice_env_snip("-cb", "checkboxes"),
	choice_env_snip("-cc", "choices"),
	choice_env_snip("-s", "solution"),
	tex_snip(
		"-fg",
		"figure",
		"insert a figure",
		[[
\begin{figure}
\centering

\includegraphics[width=0.7\textwidth]{<>}
\label{<>}
\caption{<>}
\end{figure}
  ]],
		{ i(0), rep(1), i(1) }
	),

	autosnippet({ trig = "--", hidden = true }, {
		f(function()
			if in_bullets() then
				return "\\item "
			end

			if in_multichoice() then
				return "\\choice"
			end
			if in_questions() then
				return "\\question"
			end
		end),
	}, { condition = in_multi }),
	autosnippet({ trig = "++", hidden = true }, {
		f(function()
			if in_multichoice() then
				return "\\CorrectChoice"
			end
		end),
	}, { condition = in_multi }),
}
