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
local lga_actions = require("telescope-live-grep-args.actions")
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
local action_layout = require("telescope.actions.layout")

local function telescope_buffer_dir()
  return vim.fn.expand("%:p:h")
end

-- nui layout config
local Layout = require("nui.layout")
local Popup = require("nui.popup")

local TSLayout = require("telescope.pickers.layout")

local function make_popup(options)
  local popup = Popup(options)
  function popup.border:change_title(title)
    popup.border.set_text(popup.border, "top", title)
  end

  return TSLayout.Window(popup)
end

--

telescope.setup({
  defaults = {
    layout_strategy = "flex",
    layout_config = {
      horizontal = {
        size = {
          width = "90%",
          height = "90%",
        },
      },
      vertical = {
        size = {
          width = "90%",
          height = "90%",
        },
      },
    },
    create_layout = function(picker)
      local border = {
        results = {
          top_left = "┌",
          top = "─",
          top_right = "┬",
          right = "│",
          bottom_right = "",
          bottom = "",
          bottom_left = "",
          left = "│",
        },
        results_patch = {
          minimal = {
            top_left = "┌",
            top_right = "┐",
          },
          horizontal = {
            top_left = "┌",
            top_right = "┬",
          },
          vertical = {
            top_left = "├",
            top_right = "┤",
          },
        },
        prompt = {
          top_left = "├",
          top = "─",
          top_right = "┤",
          right = "│",
          bottom_right = "┘",
          bottom = "─",
          bottom_left = "└",
          left = "│",
        },
        prompt_patch = {
          minimal = {
            bottom_right = "┘",
          },
          horizontal = {
            bottom_right = "┴",
          },
          vertical = {
            bottom_right = "┘",
          },
        },
        preview = {
          top_left = "┌",
          top = "─",
          top_right = "┐",
          right = "│",
          bottom_right = "┘",
          bottom = "─",
          bottom_left = "└",
          left = "│",
        },
        preview_patch = {
          minimal = {},
          horizontal = {
            bottom = "─",
            bottom_left = "",
            bottom_right = "┘",
            left = "",
            top_left = "",
          },
          vertical = {
            bottom = "",
            bottom_left = "",
            bottom_right = "",
            left = "│",
            top_left = "┌",
          },
        },
      }

      local results = make_popup({
        focusable = false,
        border = {
          style = border.results,
          text = {
            top = picker.results_title,
            top_align = "center",
          },
        },
        win_options = {
          winhighlight = "Normal:Normal",
        },
      })

      local prompt = make_popup({
        enter = true,
        border = {
          style = border.prompt,
          text = {
            top = picker.prompt_title,
            top_align = "center",
          },
        },
        win_options = {
          winhighlight = "Normal:Normal",
        },
      })

      local preview = make_popup({
        focusable = false,
        border = {
          style = border.preview,
          text = {
            top = picker.preview_title,
            top_align = "center",
          },
        },
      })

      local box_by_kind = {
        vertical = Layout.Box({
          Layout.Box(preview, { grow = 1 }),
          Layout.Box(results, { grow = 1 }),
          Layout.Box(prompt, { size = 3 }),
        }, { dir = "col" }),
        horizontal = Layout.Box({
          Layout.Box({
            Layout.Box(results, { grow = 1 }),
            Layout.Box(prompt, { size = 3 }),
          }, { dir = "col", size = "50%" }),
          Layout.Box(preview, { size = "50%" }),
        }, { dir = "row" }),
        minimal = Layout.Box({
          Layout.Box(results, { grow = 1 }),
          Layout.Box(prompt, { size = 3 }),
        }, { dir = "col" }),
      }

      local function get_box()
        local strategy = picker.layout_strategy
        if strategy == "vertical" or strategy == "horizontal" then
          return box_by_kind[strategy], strategy
        end

        local height, width = vim.o.lines, vim.o.columns
        local box_kind = "horizontal"
        if width < 100 then
          box_kind = "vertical"
          if height < 40 then
            box_kind = "minimal"
          end
        end
        return box_by_kind[box_kind], box_kind
      end

      local function prepare_layout_parts(layout, box_type)
        layout.results = results
        results.border:set_style(border.results_patch[box_type])

        layout.prompt = prompt
        prompt.border:set_style(border.prompt_patch[box_type])

        if box_type == "minimal" then
          layout.preview = nil
        else
          layout.preview = preview
          preview.border:set_style(border.preview_patch[box_type])
        end
      end

      local function get_layout_size(box_kind)
        return picker.layout_config[box_kind == "minimal" and "vertical" or box_kind].size
      end

      local box, box_kind = get_box()
      local layout = Layout({
        relative = "editor",
        position = "50%",
        size = get_layout_size(box_kind),
      }, box)

      layout.picker = picker
      prepare_layout_parts(layout, box_kind)

      local layout_update = layout.update
      function layout:update()
        local box, box_kind = get_box()
        prepare_layout_parts(layout, box_kind)
        layout_update(self, { size = get_layout_size(box_kind) }, box)
      end

      return TSLayout(layout)
    end,
  },
  --end nui config
  vimgrep_arguments = {
    "rg",
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
    "--hidden",
  },
  file_ignore_patterns = {
    "node_modules",
  },
  path_display = { "absolute" },
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
      ["<M-p"] = action_layout.toggle_preview,
    },
    i = {
      ["<M-p>"] = action_layout.toggle_preview,
    },
  },

  pickers = {
    find_files = {
      hidden = true,
    },
    buffers = {
      mappings = {
        i = {
          ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
        },
      },
    },
  },
  extensions = {
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = {         -- extend mappings
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " -i " }),
          ["<C-.>"] = lga_actions.quote_prompt({ postfix = " -. " }),
          -- freeze the current list and start a fuzzy search in the frozen list
          ["<C-space>"] = actions.to_fuzzy_refine,
        },
      },
      -- ... also accepts theme settings, for example:
      -- theme = "dropdown", -- use dropdown theme
      -- theme = { }, -- use own theme spec
      -- layout_config = { mirror=true }, -- mirror preview pane
    },
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

vim.keymap.set(
  "n",
  "<leader>tlg",
  ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
  { desc = "Telescope live grep args" }
)

vim.keymap.set(
  "n",
  "<leader>tlc",
  live_grep_args_shortcuts.grep_word_under_cursor,
  { desc = "Telescop live grep args under cursor" }
)

telescope.load_extension("lazygit")
telescope.load_extension("pathogen")
telescope.load_extension("fzf")
telescope.load_extension("emoji")
telescope.load_extension("live_grep_args")

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
