
return {
	{
		'kyazdani42/nvim-tree.lua',

		event = 'BufEnter',
		keys = {
			{'<leader>f', ':NvimTreeFindFileToggle<CR>', {noremap=true, silent=true}, mode="n", desc="NvimTree"},
			-- keymap('n', '<leader>f',   ':NvimTreeFindFileToggle<CR>',      options)
		},

		config = function()
			local gl        = vim.g
			local keymap    = vim.api.nvim_set_keymap
			local options   = { noremap=true, silent=true }
			local cmd       = vim.cmd           -- execute Vim commands
			-- cmd('autocmd ColorScheme * highlight highlight NvimTreeBg guibg=None')
			cmd('autocmd FileType NvimTree setlocal winhighlight=Normal:NvimTreeBg')
			--gl.nvim_tree_quit_on_open          = 1   --0 by default, closes the tree when you open a file
			--gl.nvim_tree_indent_markers        = 1   --0 by default, this option shows indent markers when folders are open
			--gl.nvim_tree_highlight_opened_files= 1   --0 by default, will enable folder and file icon highlight for opened files/directories.
			require'nvim-tree'.setup {
				renderer = {
					highlight_opened_files = "name"
				},
				actions = {
					open_file = {
						quit_on_open = true,
						resize_window = false,
						window_picker ={
							enable = false
						}
					},
				},
				respect_buf_cwd = false,

				disable_netrw       = true,
				hijack_netrw        = true,
				--open_on_setup       = false,
				--ignore_ft_on_setup  = {},
				--auto_close          = false,
				open_on_tab         = false,
				hijack_cursor       = false,
				update_cwd          = true,
				respect_buf_cwd = false,
				sync_root_with_cwd = true, -- NOTE: New.
				-- option was renamed
				--update_to_buf_dir   = {
				hijack_directories   = {
					enable = true,
					auto_open = true,
				},
				diagnostics = {
					enable = false,
					icons = {
						hint = "",
						info = "",
						warning = "",
						error = "",
					}
				},
				git = {
					enable = false,
				},
				update_focused_file = {
					enable      = true,
					-- update_cwd  = true, -- XXX(SLEE) Looks like this is what I want: if file is not an ancestor, then cwd to its parent
					update_cwd  = false, -- XXX(SLEE) Looks like this is what I want: if file is not an ancestor, then cwd to its parent
					ignore_list = {}
				},
				system_open = {
					cmd  = nil,
					args = {}
				},
				filters = {
					dotfiles = false,
					custom = {
						"__pycache__",
					}
				},

				view = {
					width = 45,
					-- height = 30,
					-- hide_root_folder = false,
					side = 'left',
					--auto_resize = false,
					--[[mappings = {
						custom_only = false,
						list = {
							{ key = "-",     cb = ":lua require'nvim-tree'.on_keypress('dir_up')<CR>:lua require'nvim-tree'.on_keypress('refresh')<CR>" },
						}
					}--]]
				}
			}

			-- Note: global map
			-- keymap('n', '<leader>f',   ':NvimTreeFindFileToggle<CR>',      options)
		end
	},



	{
	"nvim-pack/nvim-spectre",
	build = false,
	cmd = "Spectre",
	opts = { open_cmd = "noswapfile vnew" },
	-- stylua: ignore
	keys = {
		{ "<leader>sr", function() require("spectre").open() end, desc = "Replace in Files (Spectre)" },
	},
	},


	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss All Notifications",
			},
		},
		opts = {
			stages = "static",
			timeout = 8000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			on_open = function(win)
				vim.api.nvim_win_set_config(win, { zindex = 100 })
			end,
		},
		init = function()
			-- when noice is not enabled, install notify on VeryLazy
			--[[
			if not LazyVim.has("noice.nvim") then
				LazyVim.on_very_lazy(function()
					vim.notify = require("notify")
				end)
			end
			--]]
		end,
	},

{
  "lukas-reineke/indent-blankline.nvim",
		event = 'BufEnter',
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = { show_start = false, show_end = false },
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
  },
  main = "ibl",
},


{
  "folke/noice.nvim",
  event = "VeryLazy",
  -- enabled = false,
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },

	-- cmdline = {enabled=false, view="cmdline", opts = {replace = false}, replace=false},
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "mini",
      },
    },
    presets = {
      bottom_search = true,
      -- command_palette = true,
      long_message_to_split = true,
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>sn", "", desc = "+noice"},
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
    { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
    { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
    { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
  },
  config = function(_, opts)
    -- HACK: noice shows messages from before it was enabled,
    -- but this is not ideal when Lazy is installing plugins,
    -- so clear the messages in this case.
    if vim.o.filetype == "lazy" then
      vim.cmd([[messages clear]])
    end
    require("noice").setup(opts)
  end,
}

}
