
return {
			-- {'nvim-telescope/telescope-ui-select.nvim' },

			{
				'nvim-telescope/telescope.nvim',
				enabled = true,

				-- version = false, -- telescope did only one release, so use HEAD for now
				dependencies = {
					'nvim-lua/plenary.nvim',
							'nvim-telescope/telescope-ui-select.nvim',

					{
						"nvim-telescope/telescope-fzf-native.nvim",
						build = "make"
					},

				},

				config = function(_,opts)
					require('telescope').setup(opts)
					require('telescope').load_extension('fzf')
					require('telescope').load_extension('ui-select')
				end,

				event = 'BufEnter',
				keys = {
					{
						"<localleader>,",
						"<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
						desc = "Switch Buffer",
					},

					{ "<localleader>\\", "<cmd>lua require('telescope.builtin').builtin()<CR>", desc = "Telescope" },

					{ "<localleader>/", "<cmd>lua require('telescope.builtin').live_grep({file_ignore_pattern={\"build*\"}}) <CR>", desc = "Live Grep (Root Dir)" },
					{ "<localleader>ss", "<cmd>lua require('telescope.builtin').live_grep({file_ignore_pattern={\"build*\"}}) <CR>", desc = "Live Grep (Root Dir)" },
					-- { "<localleader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
					-- { "<localleader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },

					{ "<localleader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
					-- { "<localleader><space>", LazyVim.pick("auto"), desc = "Find Files (Root Dir)" },
					-- find
					{ "<localleader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
					{ "<localleader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files (cwd)" },
					{ "<localleader>fF", "<cmd>Telescope find_files root=false<cr>", desc = "Find Files (cwd)" },
					{ "<localleader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
					{ "<localleader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent / Old Files" },
					-- { "<localleader>fR", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
					-- { "<localleader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },

					-- git
					{ "<localleader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
					{ "<localleader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
					-- search
					{ '<localleader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
					{ "<localleader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
					{ "<localleader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
					{ "<localleader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
					{ "<localleader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
					{ "<localleader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
					{ "<localleader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
					{ "<localleader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
					{ "<localleader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
					{ "<localleader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
					{ "<localleader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
					{ "<localleader>sl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
					{ "<localleader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
					{ "<localleader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
					{ "<localleader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
					-- { "<localleader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
					{ "<localleader>r", "<cmd>Telescope resume<cr>", desc = "Resume" },
					{ "<localleader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
					-- { "<leader>sw", LazyVim.pick("grep_string", { word_match = "-w" }), desc = "Word (Root Dir)" },
					-- { "<leader>sW", LazyVim.pick("grep_string", { root = false, word_match = "-w" }), desc = "Word (cwd)" },
					-- { "<leader>sw", LazyVim.pick("grep_string"), mode = "v", desc = "Selection (Root Dir)" },
					-- { "<leader>sW", LazyVim.pick("grep_string", { root = false }), mode = "v", desc = "Selection (cwd)" },
					-- { "<leader>uC", LazyVim.pick("colorscheme", { enable_preview = true }), desc = "Colorscheme with Preview" },
					{ "<localleader>uC", "<cmd>Telescope colorscheme enable_preview=true<cr>", desc = "Colorscheme with Preview" },
					{ '<leader>b', "<cmd>lua require('telescope.builtin').buffers({sort_mru=1})<CR>", silent=true, noremap=true, desc="Buffers"},
					{ '<leader>d', "<cmd>lua require('telescope.builtin').buffers({sort_mru=1, only_cwd=1, ignore_current_buffer=1})<CR>", silent=true, noremap=true, desc="Buffers (cwd)"},

					-- LSP
					{ "<Space>r", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", desc = "LspReferences" },
					{ "<Space>c", "<cmd>lua require('telescope.builtin').lsp_incoming_calls()<cr>", desc = "LspIncomingCalls" },
					{ "<Space>C", "<cmd>lua require('telescope.builtin').lsp_outgoing_calls()<cr>", desc = "LspOutgoingCalls" },
					{ "<Space>s", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", desc = "LspDocumentSymbols" },
					{ "<Space>S", "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>", desc = "LspWorkspaceSymbols" },
					{ "<Space>W", "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>", desc = "LspDynamicWorkspaceSymbols" },
					{ "<Space>d", "<cmd>lua require('telescope.builtin').diagnostics({bufnr=0})<cr>", desc = "LspBufDiagnostics" },
					{ "<Space>D", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", desc = "LspAllDiagnostics" },
					{ "<Space>i", "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>", desc = "LspImplementations" },
					{ "<Space>I", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", desc = "LspDefinitions" },
					{ "<Space>t", "<cmd>lua require('telescope.builtin').lsp_type_definitions()<cr>", desc = "LspTypeDefinitions" },




					{
						"<localleader>sy",
						function()
							require("telescope.builtin").lsp_document_symbols({
								-- symbols = LazyVim.config.get_kind_filter(),
							})
						end,
						desc = "Goto Symbol",
					},
					{
						"<localleader>sY",
						function()
							require("telescope.builtin").lsp_dynamic_workspace_symbols({
								-- symbols = LazyVim.config.get_kind_filter(),
							})
						end,
						desc = "Goto Symbol (Workspace)",
					},
				},

				opts = function()
					local actions = require("telescope.actions")

					local open_with_trouble = function(...)
						return require("trouble.sources.telescope").open(...)
					end
					local find_files_no_ignore = function()
						local action_state = require("telescope.actions.state")
						local line = action_state.get_current_line()
						-- LazyVim.pick("find_files", { no_ignore = true, default_text = line })()
						return "<cmd>Telescope find_files<cr>"
					end
					local find_files_with_hidden = function()
						local action_state = require("telescope.actions.state")
						local line = action_state.get_current_line()
						-- LazyVim.pick("find_files", { hidden = true, default_text = line })()
						return "<cmd>Telescope find_files hidden=true default_text=line<cr>"
					end

					return {
						defaults = {
							-- prompt_prefix = " ",
							-- selection_caret = " ",
							prompt_prefix       = "🔎︎ ",
							selection_caret     = "➤ ",
							use_less            = true,
							-- open files in the first window that is an actual file.
							-- use the current window if no other window is available.
							get_selection_window = function()
								local wins = vim.api.nvim_list_wins()
								table.insert(wins, 1, vim.api.nvim_get_current_win())
								for _, win in ipairs(wins) do
									local buf = vim.api.nvim_win_get_buf(win)
									if vim.bo[buf].buftype == "" then
										return win
									end
								end
								return 0
							end,
							mappings = {
								i = {
									-- ["<c-t>"] = open_with_trouble,
									["<a-t>"] = open_with_trouble,
									["<a-i>"] = find_files_no_ignore,
									["<a-h>"] = find_files_with_hidden,
									["<C-Down>"] = actions.cycle_history_next,
									["<C-Up>"] = actions.cycle_history_prev,
									["<C-f>"] = actions.preview_scrolling_down,
									["<C-b>"] = actions.preview_scrolling_up,
									['<c-q>'] = actions.delete_buffer -- remove entry after marking with `Tab` and pressing C-q
								},
								n = {
									["q"] = actions.close,
									['<c-q>'] = actions.delete_buffer -- remove entry after marking with `Tab` and pressing C-q
								},
							},

							file_ignore_patterns= {
								"__pycache__/", "__pycache__/*",
								"build/",       "gradle/", "node_modules/", "node_modules/*", "obj/Debug",
								"smalljre_*/*", "target/", "vendor/*",      "bin/Debug",      "venv/",
								".dart_tool/", ".git/", ".github/", ".gradle/",".idea/", ".vscode/",
								"%.sqlite3", "%.ipynb", "%.lock", "%.pdb",   "%.so",
								"%.dll",     "%.class", "%.exe",  "%.cache", "%.pdf",  "%.dylib",
								"%.jar",     "%.docx",  "%.met",  "%.burp",  "%.mp4",  "%.mkv",   "%.rar",
								"%.zip",     "%.7z",    "%.tar",  "%.bz2",   "%.epub", "%.flac",  "%.tar.gz",
							},

							initial_mode = "insert",
							selection_strategy  = "reset",
							sorting_strategy    = "ascending",
							layout_strategy     = "horizontal",
							layout_config = {
								horizontal = {
									mirror = false,
									prompt_position = "top"
								},
								vertical = {
									mirror = false
								},
							},

						},
					}
				end,
			}
		}
