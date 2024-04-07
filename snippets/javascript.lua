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

local group = vim.api.nvim_create_augroup("Javascript Snippets", { clear = true })
local file_pattern = "*.js"

local function cs(trigger, nodes, opts) --{{{
	local snippet = s(trigger, nodes)
	local target_table = snippets

	local pattern = file_pattern
	local keymaps = {}

	if opts ~= nil then
		-- check for custom pattern
		if opts.pattern then
			pattern = opts.pattern
		end

		-- if opts is a string
		if type(opts) == "string" then
			if opts == "auto" then
				target_table = autosnippets
			else
				table.insert(keymaps, { "i", opts })
			end
		end

		-- if opts is a table
		if opts ~= nil and type(opts) == "table" then
			for _, keymap in ipairs(opts) do
				if type(keymap) == "string" then
					table.insert(keymaps, { "i", keymap })
				else
					table.insert(keymaps, keymap)
				end
			end
		end

		-- set autocmd for each keymap
		if opts ~= "auto" then
			for _, keymap in ipairs(keymaps) do
				vim.api.nvim_create_autocmd("BufEnter", {
					pattern = pattern,
					group = group,
					callback = function()
						vim.keymap.set(keymap[1], keymap[2], function()
							ls.snip_expand(snippet)
						end, { noremap = true, silent = true, buffer = true })
					end,
				})
			end
		end
	end

	table.insert(target_table, snippet) -- insert snippet into appropriate table
end --}}}
cs( -- for([%w_]+) JS For Loop snippet{{{
	{ trig = "for([%w_]+)", regTrig = true, hidden = true },
	fmt(
		[[
for (let {} = 0; {} < {}; {}++) {{
  {}
}}

{}
    ]],
		{
			d(1, function(_, snip)
				return sn(1, i(1, snip.captures[1]))
			end),
			rep(1),
			c(2, { i(1, "num"), sn(1, { i(1, "arr"), t(".length") }) }),
			rep(1),
			i(3, "// TODO:"),
			i(4),
		}
	)
) --}}}

local arrowFunctionWithBrackets = snippet(
	{ trig = "fa2", regTrig = true },
	fmt(
		[[
  ({}) => {{
    {}
  }}
  ]],
		{ i(1), i(2) }
	)
)

local arrowFunctionWithoutBrackets = snippet({ trig = "fa1", regTrig = true }, fmt("({}) => {}", { i(1), i(2) }))

local nodeArrowFunctionWithBrackets = snippet(
	{ trig = "fa3", regTrig = true },
	fmt(
		[[
  (req, res) => {{
    {}
  }}
  ]],
		{ i(1) }
	)
)

local bunTestsImport =
	snippet({ trig = "bti1", regTrig = true }, fmt('import {{describe, expect, test, {}}} from "bun:test"', { i(1) }))

local bunTests = snippet(
	{ trig = "bt1", regTrig = true },
	fmt(
		[[
  describe("{}",() => {{
    test("{}", () => {{
      expect({}).{}
    }});
  }})
  ]],
		{ i(1), i(2), i(3), i(4) }
	)
)

local bunTest = snippet(
	{ trig = "bt2", regTrig = true },
	fmt(
		[[
  test("{}", () => {{
    expect({}).{}
  }});
]],
		{ i(1), i(2), i(3) }
	)
)
local leetcodeTest = snippet(
	{ trig = "leetcodetestsnippet", regTrig = true },
	fmt(
		[[
import {{beforeAll ,describe, expect, test, }} from "bun:test"

 describe("leetcode tests",() => {{
   let case1;
   let case2;
    beforeAll(() => {{
      case1 = {};
      case2 = {};
    }})
    test("add case1 with {}", () => {{
      expect({}).{}
    }});
    test("add case2 with {}", () => {{
      expect({}).{}
    }});
  }})
    ]],
		{ i(1), i(2), i(3), i(4), i(5), i(6), i(7), i(8) }
	)
)

local readline = snippet(
	{ trig = "readlinesnippet", regTrig = true },
	fmt(
		[[
const readline = require("readline");

const rl = readline.createInterface({{
  input: process.stdin,
  output: process.stdout
}});

rl.on("line", (input) => {{
  {}
}});
]],
		{ i(1) }
	)
)

table.insert(autosnippets, arrowFunctionWithBrackets)
table.insert(autosnippets, arrowFunctionWithoutBrackets)
table.insert(autosnippets, nodeArrowFunctionWithBrackets)
table.insert(autosnippets, bunTests)
table.insert(autosnippets, bunTestsImport)
table.insert(autosnippets, bunTest)
table.insert(autosnippets, leetcodeTest)
table.insert(autosnippets, readline)

return snippets, autosnippets
