local ls = require("luasnip") --{{{
local snippet = ls.snippet
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local arrowFunc = snippet("fa1", t("() => {}"))

table.insert(autosnippets, arrowFunc)

return snippets, autosnippets
