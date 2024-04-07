local catppuccin = require("catppuccin")
catppuccin.setup({
	flavour = "mocha",
	-- flavour = "macchiato",
	-- flavour = "frappe",
	-- flavour = "latte",
	transparent_background = false,
	show_end_of_buffer = false,
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.20,
	},
	integrations = {
		which_key = true,
	},
	color_overrides = {
		mocha = {
			base = "#10101a",
		},
	},
})

vim.cmd.colorscheme("catppuccin")

-- local base1 = "#2D3145"

local colors = require("catppuccin.palettes").get_palette()
require("catppuccin.lib.highlighter").syntax({
	-- MsgArea = { bg = colors.mantle },
	NormalFloat = { bg = "none" },
	CursorLine = { bg = colors.surface0 },
	-- PmenuSel = { fg = colors.mantle, bg = colors.blue },
	-- FloatBorder = { fg = colors.surface0, bg = colors.surface0 },
})
