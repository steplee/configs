
return {
		{
			'nvim-lualine/lualine.nvim',
			dependencies = {
				{'nvim-tree/nvim-web-devicons', opt = true},
				{'linrongbin16/lsp-progress.nvim', config = function() require('lsp-progress').setup() end },
			},
			config = function()
				-- Based on "horizon"
				local colors = {
					black        = '#1c1e26',
					white        = '#6C6F93',
					red          = '#F43E5C',
					green        = '#49F740',
					blue         = '#15B2FC',
					yellow       = '#F09383',
					mutedGreen   = '#aaffcc',
					mutedRose     = '#ddaaca',
					darkgray     = '#1f1C2a',
					darkgrayIns     = '#1a1f2f',
					lightgray    = '#2E203E',
					lightgray2    = '#4E505E',
					inactivegray = '#1f1E2f',
				}
				local my_theme = {
					normal = {
						-- a = { bg = colors.mutedGreen, fg = colors.black, },
						a = { bg = colors.mutedRose, fg = colors.black, },
						b = { bg = colors.lightgray, fg = colors.white },
						c = { bg = colors.darkgray, fg = colors.white },
					},
					insert = {
						a = { bg = colors.blue, fg = colors.black, gui = 'bold' },
						b = { bg = colors.lightgray, fg = colors.white },
						c = { bg = colors.darkgrayIns, fg = colors.white },
					},
					visual = {
						a = { bg = colors.yellow, fg = colors.black, gui = 'bold' },
						b = { bg = colors.lightgray, fg = colors.white },
						c = { bg = colors.darkgray, fg = colors.white },
					},
					replace = {
						a = { bg = colors.red, fg = colors.black, gui = 'bold' },
						b = { bg = colors.lightgray, fg = colors.white },
						c = { bg = colors.darkgray, fg = colors.white },
					},
					command = {
						a = { bg = colors.green, fg = colors.black, gui = 'bold' },
						b = { bg = colors.lightgray, fg = colors.white },
						c = { bg = colors.darkgray, fg = colors.white },
					},
					inactive = {
						a = { bg = colors.inactivegray, fg = colors.lightgray2, gui = 'bold' },
						b = { bg = colors.inactivegray, fg = colors.lightgray2 },
						c = { bg = colors.inactivegray, fg = colors.lightgray2 },
					},
				}


				require('lualine').setup({
					-- options = {theme = 'horizon'},
					options = {theme = my_theme},
					sections = {
						lualine_a = { {'mode', fmt = function(str) return string.format("%-7s",string.lower(str)) end} },
						-- NOTE: branch + diff are nice but slow.
						-- lualine_b = {'branch', 'diff'},
						lualine_b = {
							{'diagnostics', sources={'nvim_lsp', 'nvim_diagnostic'}, always_visible=false },
						},
						lualine_c = {'filename',
							require('lsp-progress').progress,
						},
						lualine_x = {'encoding', 'fileformat', 'filetype' },
						-- lualine_x = {'encoding', 'fileformat', 'filetype' },
						lualine_y = {'progress'},
						lualine_z = {'location'}
					},
					inactive_sections = {
						lualine_a = {},
						lualine_b = {},
						lualine_c = {'filename'},
						lualine_x = {'location'},
						lualine_y = {},
						lualine_z = {}
					},

				})

			vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
			vim.api.nvim_create_autocmd("User", {
				group = "lualine_augroup",
				pattern = "LspProgressStatusUpdated",
				callback = require("lualine").refresh,
			})

			end
		}
	}
