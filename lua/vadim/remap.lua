vim.g.mapleader = " "

-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) <- not working

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "smooth scroll" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "smooth scroll" })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
--vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

--vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
--vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Normal mode in insert menu" })

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "fast format" })

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set(
	"n",
	"<leader><C-s>",
	[[:%s:\<<C-r><C-w>\>:<C-r><C-w>:gI<Left><Left><Left>]],
	{ desc = "fast substitute" }
)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "add chmod x" })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/vadim/packer.lua<CR>", { desc = "Open packer.lua" })
--vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

--From craftzdog maps.lua
-- Select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- New tab
vim.keymap.set("n", "te", ":tabedit<cr>", { desc = "new tab" })
-- Split window
vim.keymap.set("n", "<leader>ss", ":split<Return><C-w>w", { desc = "split" })
vim.keymap.set("n", "<leader>sv", ":vsplit<Return><C-w>w", { desc = ":vsplit" })

--Insert mode
vim.keymap.set("i", "<a-l>", "<right>")
vim.keymap.set("i", "<a-h>", "<left>")
vim.keymap.set("i", "<a-j>", "<down>")
vim.keymap.set("i", "<a-k>", "<up>")
--Save
vim.keymap.set({ "i", "n" }, "<a-s>", "<cmd>wa<CR><cmd>echo 'Save'<CR> ", { desc = "Save all" })

--:nohlsearch
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = ":nohlsearch" })

--debugging
vim.keymap.set("n", "<F5>", function()
	require("dap").continue()
end, { desc = "continue" })
vim.keymap.set("n", "<F6>", function()
	require("dap").step_over()
end, { desc = "step_over" })
vim.keymap.set("n", "<F7>", function()
	require("dap").step_into()
end, { desc = "step_into" })
vim.keymap.set("n", "<F8>", function()
	require("dap").step_out()
end, { desc = "step_out" })
vim.keymap.set("n", "<Leader>db", function()
	require("dap").toggle_breakpoint()
end, { desc = "toggle breakpoint" })
vim.keymap.set("n", "<leader>da", function()
	require("dapui").elements.watches.add()
end, { desc = "dapui add watch" })
vim.keymap.set("n", "<leader>dd", function()
	require("dapui").elements.watches.remove()
end, { desc = "dapui remove watch" })
vim.keymap.set("n", "<leader>de", function()
	require("dapui").eval()
end, { desc = "dapui eval(calculate) expression" })
--debugging dap-ui
vim.keymap.set("n", "<leader>o", "<cmd>lua require('dapui').toggle() <CR>", { desc = "toggle dapui" })

-- Increment/decrement
vim.keymap.set("n", "+", "<C-a>", { desc = "increment" })
vim.keymap.set("n", "-", "<C-x>", { desc = "decrement" })

--Colorizer
vim.keymap.set("n", "<leader><leader>c", "<cmd>ColorToggle<CR>", { desc = "highlight hex color" })

--myGreetingLua
vim.keymap.set(
	"n",
	"<leader><leader>g",
	"<cmd>luafile ~/.config/nvim/lua/vadim/mylua.lua<CR>",
	{ desc = "Hello Vadim lua function" }
)

--Diffview
vim.keymap.set("n", "<leader>do", "<cmd>DiffviewOpen<CR>", { desc = ":DiffviewOpen" })
vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<CR>", { desc = ":DiffviewClose" })

--Telescope
vim.keymap.set("n", "<leader>tb", "<cmd>Telescope buffers<CR>", { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>td", "<cmd>Telescope diagnostics<CR>", { desc = "Telescope diagnostics" })
vim.keymap.set("n", "<leader>tk", "<cmd>Telescope keymaps<CR>", { desc = "Telescope keymaps" })

--gitsigns
vim.keymap.set("n", "<leader>hn", "<cmd>Gitsigns next_hunk<CR>", { desc = "next_hunk" })
vim.keymap.set("n", "<leader>hp", "<cmd>Gitsigns prev_hunk<CR>", { desc = "prev_hunk" })
vim.keymap.set("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "stage_hunk" })
vim.keymap.set("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", { desc = "undo_stage_hunk" })
vim.keymap.set("n", "<leader>hb", "<cmd>Gitsigns blame_line<CR>", { desc = "blame_line" })
vim.keymap.set(
	"n",
	"<leader>hsb",
	'<cmd>Gitsigns stage_buffer<CR><cmd> echo "stage buffer"<CR>',
	{ desc = "stage_buffer" }
)
vim.keymap.set("n", "<leader>hph", "<cmd>Gitsigns preview_hunk<CR>", { desc = "preview_hunk" })

--fugitive
vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>", { desc = ":Git status" })
vim.keymap.set("n", "<leader>gw", "<cmd>Gwrite<CR><cmd>echo 'Gwirte'<CR>", { desc = ":Gwrite" })
vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = ":Git commit" })
vim.keymap.set("n", "<leader>gb", "<cmd>Git branch<CR>", { desc = ":Git branch" })
vim.keymap.set("n", "<leader>gt", "<cmd>Git stash<CR>", { desc = ":Git stash" })
vim.keymap.set("n", "<leader>gp", "<cmd>Git push<CR>", { desc = ":Git push" })
vim.keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>", { desc = ":Gvdiffsplit" })
--visual fugitive
vim.keymap.set("v", "<leader>dg", ":'<,'>diffget<CR>", { desc = ":diffget" })
vim.keymap.set("v", "<leader>dp", ":'<,'>diffput<CR>", { desc = ":diffput" })

--toggleterminal
--vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { desc = ':ToggleTerm' })

--lazygit
vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = ":LazyGit" })

--undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree" })

--pathogen telescope extension
vim.keymap.set(
	"v",
	"<leader>tg",
	require("telescope").extensions["pathogen"].grep_string,
	{ desc = "pathogen grep_string" }
)
vim.keymap.set(
	"n",
	"<leader>tlg",
	":Telescope pathogen live_grep<CR>",
	{ silent = true, desc = "Telescope path live grep" }
)
vim.keymap.set("n", "<leader>tp", ":Telescope pathogen<CR>", { silent = true, desc = "Telescope pathogen" })
vim.keymap.set(
	"n",
	"<leader>tf",
	":Telescope pathogen find_files hidden=true<CR>",
	{ silent = true, desc = "Telescope path find files" }
)
vim.keymap.set(
	"n",
	"<leader>tg",
	":Telescope pathogen grep_string<CR>",
	{ silent = true, desc = "Telescope path grep string" }
)

-- telescope emoji extension
vim.keymap.set("n", "<leader>te", "<cmd>Telescope emoji<CR>", { desc = "Telescope emoji" })

--nvim-tree
--vim.keymap.set('n', '<leader>nt', '<cmd>NvimTreeToggle<CR>', { desc = 'NvimTreeToggle' })

--numeric lines
vim.keymap.set("n", "<leader>en", ":s:^\\s*\\zs:\\=(line('.')-line(\"'<\")).'. '<Home>", { desc = "Numeric text" })

--for node js
vim.keymap.set("n", "<leader>vs", "<cmd>!node %<CR>", { desc = "start Node.js" })

--toggle numbers
vim.keymap.set("n", "<leader><leader>n", "<cmd>set relativenumber!<CR>")

--start of the line and end of the line
vim.keymap.set("n", "<leader><leader>s", "^", { desc = "start of the line" })
vim.keymap.set("n", "<leader><leader>e", "$", { desc = "end of the line" })

--oil open
vim.keymap.set("n", "<leader><leader>o", "<cmd>Oil<CR>", { desc = "open oil file explorer" })

--spliting joining blocks treesj
vim.keymap.set("n", "<leader><leader>t", "<cmd>TSJToggle<CR>", { desc = "Spliting joining blocks" })

--autosave toggle
--vim.keymap.set('n', '<leader>as', "<cmd>ASToggle<CR>", { desc = "Autosave toggle" })

--prettier
vim.keymap.set("n", "<leader>p", "<cmd>Prettier<CR>", { desc = "Prettier" })

--conform manual format
vim.keymap.set({ "n", "v" }, "<leader><leader>f", function()
	require("conform").format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end, { desc = "conform format" })

--nvim-lint for manual lint
vim.keymap.set("n", "<leader><leader>l", function()
	require("lint").try_lint()
end, { desc = "lint with nvim-lint" })

--clear list
vim.keymap.set(
	"n",
	"<leader><leader><leader>c",
	"<cmd>g/ .*/s//<CR><cmd>nohlsearch<CR>gg",
	{ desc = "fast clear list for practice" }
)

--IBL toggle
vim.keymap.set("n", "<leader>it", "<cmd>IBLToggle<CR>", { desc = "IBL Toggle" })

--neovim save+close
vim.keymap.set("n", "<M-c>", ":wq<CR>", { desc = "Save and close" })

--neovim close
vim.keymap.set("n", "<M-q>", ":q<CR>", { desc = "Close window" })

-- ; in the end
vim.keymap.set("n", "<leader>;", "<S-$>a;<ESC>", { desc = "my snippet for ; in the end" })

--nvim-cmp
vim.keymap.set("i", "<C-c>", "<cmd>lua require('cmp').close() <cr>")

--codeium autocomplete
vim.keymap.set("n", "<leader><leader>m", "<cmd>CodeiumManual<CR>", { desc = "Codeium manual" })
vim.keymap.set("i", "<C-g>", function()
	return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true })
vim.keymap.set("i", "<C-x>", function()
	return vim.fn["codeium#Clear"]()
end, { expr = true, silent = true })
vim.keymap.set("i", "<C-f>", function()
	return vim.fn["codeium#Complete"]()
end, { expr = true, silent = true })
