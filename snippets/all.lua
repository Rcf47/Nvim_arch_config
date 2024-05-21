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
end                                   --}}}

local tryca = snippet(
  { trig = "tryca", regTrig = true },
  fmt(
    [[
try {{
  {}
}} catch (error) {{
  {}
}}
]],
    { i(2), i(1) }
  )
)

local afa1 = snippet(
  { trig = "afa1", regTrig = true },
  fmt(
    [[
async ({}) => {{
  {}
}};
]],
    { i(1), i(2) }
  )
)

local cafa1 = snippet(
  { trig = "cafa1", regTrig = true },
  fmt(
    [[
const {} = async ({}) => {{
  {}
}};
]],
    { i(1), i(2), i(3) }
  )
)

table.insert(snippets, tryca)
table.insert(snippets, afa1)
table.insert(snippets, cafa1)

return snippets, autosnippets
