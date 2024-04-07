local status, lualine = pcall(require, "lualine")
if not status then
	return
end

local function codium()
	return vim.api.nvim_call_function("codeium#GetStatusString", {})
end
vim.g.lualine_xkblayout_codes = {
	["2SetKorean"] = "KR",
	["Chinese"] = "CN",
	["Japanese"] = "JP",
	["us"] = "ENG",
	["ru"] = "РУС",
	["ua"] = "УКР",
	["Eng"] = "ENG",
	["Rus"] = "RU",
}
lualine.setup({
	options = {
		icons_enabled = true,
		theme = "catppuccin",
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		disabled_filetypes = {},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = {
			{
				"filename",
				file_status = true, -- displays file status (readonly status, modified status)
				path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
			},
		},
		lualine_x = {

			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = {
					error = " ",
					warn = " ",
					info = " ",
					hint = " ",
				},
			},
			"encoding",
			{ codium },
			"filetype",
		},
		lualine_y = { "progress" },
		lualine_z = { { "xkblayout", icon = "" } },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {
			{
				"filename",
				file_status = true, -- displays file status (readonly status, modified status)
				path = 2, -- 0 = just filename, 1 = relative path, 2 = absolute path
			},
		},
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = { "fugitive" },
})
