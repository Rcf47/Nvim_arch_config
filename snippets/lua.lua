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

local requireLua = snippet("req", fmt("local {} = require('{}')", { i(1, "default"), rep(1) }))

table.insert(snippets, requireLua)

return snippets, autosnippets
