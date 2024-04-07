local ls = require("luasnip")
local types = require("luasnip.util.types")
local snippet = ls.snippet
local s = ls.s
local t = ls.text_node
local c = ls.choice_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
ls.config.set_config({
	-- This tells LuaSnip to remember to keep around the last snippet.
	-- You can jump back into it even if you move outside of the selection
	history = false,

	-- This one is cool cause if you have dynamic snippets, it updates as you type!
	updateevents = "TextChanged,TextChangedI",

	-- Autosnippets:
	enable_autosnippets = true,

	-- Crazy highlights!!
	-- #vid3
	-- ext_opts = nil,
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { " « ", "NonTest" } },
			},
		},
	},
})
-- <c-n> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<c-n>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })
vim.keymap.set({ "i" }, "<C-K>", function()
	ls.expand()
end, { silent = true })

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<c-j>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })
-- <c-q> is my jump forward key
vim.keymap.set({ "i", "s" }, "<c-s>", function()
	if ls.jumpable(1) then
		ls.jump(1)
	end
end, { silent = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
vim.keymap.set("i", "<c-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

-- shorcut to source my luasnips file again, which will reload my snippets
vim.keymap.set("n", "<leader><leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")

ls.add_snippets("all", {
	snippet("simple", t("wow, you were right!")),
	snippet("try", c(1, { t({ "hello" }), t({ "world" }) })),
})
