require("dap-vscode-js").setup({
	-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
	-- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
	-- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
	-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
	-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
	-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

for _, language in ipairs({ "typescript", "javascript" }) do
	require("dap").configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
		-- not working dap config
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch bun",
			cwd = "${workspaceFolder}",
			runtimeArgs = { "--inspect" },
			program = "${file}",
			runtimeExecutable = "bun",
			attachSimplePort = 6499,
		},
	}
end

--for dap-ui
require("neodev").setup({
	library = { plugins = { "nvim-dap-ui" }, types = true },
	...,
})
require("dapui").setup()
local dap2, dapui = require("dap"), require("dapui")
dap2.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
