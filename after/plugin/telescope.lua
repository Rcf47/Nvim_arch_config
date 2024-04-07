local builtin = require("telescope.builtin")
--vim.keymap.set('n', '<leader>tf', builtin.find_files, { desc = 'Telescope find files' })
--vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope git files' })
--vim.keymap.set('n', '<leader>tg', function()
-- builtin.grep_string({ search = vim.fn.input("Grep > ") });
--end, { desc = 'Telescope grep' })

local status, telescope = pcall(require, "telescope")
if not status then
	return
end
local actions = require("telescope.actions")

local fb_actions = require("telescope").extensions.file_browser.actions

local function telescope_buffer_dir()
	return vim.fn.expand("%:p:h")
end

telescope.setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules",
		},
		path_display = { "smart" },
		-- preview config
		--    layout_config = {
		--      horizontal = {
		--        preview_width = 0.5,
		--        preview_cutoff = 0,
		--      },
		--    },
		--    layout_strategy = 'flex',
		mappings = {
			n = {
				["q"] = actions.close,
			},
		},
	},
	extensions = {
		file_browser = {
			theme = "dropdown",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				-- your custom insert mode mappings
				["i"] = {
					["<C-w>"] = function()
						vim.cmd("normal vbd")
					end,
				},
				["n"] = {
					-- your custom normal mode mappings
					["N"] = fb_actions.create,
					["h"] = fb_actions.goto_parent_dir,
					["/"] = function()
						vim.cmd("startinsert")
					end,
				},
			},
		},
	},
})

telescope.load_extension("file_browser")

vim.keymap.set("n", "<leader>tn", function()
	telescope.extensions.file_browser.file_browser({
		path = "%:p:h",
		cwd = telescope_buffer_dir(),
		respect_gitignore = false,
		hidden = true,
		grouped = true,
		previewer = false,
		initial_mode = "normal",
		layout_config = { height = 40 },
	})
end, { desc = "Telescope file browser" })

telescope.load_extension("lazygit")
telescope.load_extension("pathogen")
telescope.load_extension("fzf")
telescope.load_extension("emoji")

local base1 = "#2D3145"
local base2 = "#32364A"
local colors = require("catppuccin.palettes").get_palette()
require("catppuccin.lib.highlighter").syntax({
	TelescopePromptNormal = { fg = colors.text, bg = base1 },
	TelescopePromptBorder = { fg = base1, bg = base1 },
	TelescopePromptTitle = { fg = colors.subtext1, bg = base1 },
	TelescopeResultsNormal = { fg = colors.subtext1, bg = base1 },
	TelescopeResultsBorder = { fg = base1, bg = base1 },
	TelescopeResultsTitle = { fg = colors.subtext1, bg = base1 },
	TelescopePreviewNormal = { bg = base2 },
	TelescopePreviewBorder = { fg = base2, bg = base2 },
	TelescopePreviewTitle = { fg = colors.subtext1, bg = base2 },
	-- TelescopeMultiSelection = { fg = colors.text, bg = colors.surface1, style = { "bold" }  },
	-- TelescopeSelection = { fg = colors.text, bg = colors.surface1, style = { "bold" } },

	-- TelescopePromptNormal = { bg = colors.mantle },
	-- TelescopeResultsNormal = { bg = colors.mantle },
	-- TelescopePreviewNormal = { bg = colors.mantle },
})
