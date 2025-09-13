
return {

  -- { "projekt0n/github-nvim-theme" },
  {"Shatur/neovim-ayu"},
  -- {"nyoom-engineering/oxocarbon.nvim"},
  -- {"scottmckendry/cyberdream.nvim"},
  -- {"olimorris/onedarkpro.nvim"},
  -- {"savq/melange-nvim"},
  {"thesimonho/kanagawa-paper.nvim"},
  -- {"DeaDWTeaM/retrolegends.nvim"},
  -- {"hendriknielaender/stardust.nvim"}, -- contrast too high
  -- {"nickkadutskyi/jb.nvim"},
  -- {"neg-serg/neg.nvim"},
  -- {"ptdewey/monalisa-nvim"}, -- could be good but too high contrast
  {"rose-pine/neovim"}, -- all time best
  -- {"kvrohit/mellow.nvim"}, -- similar to oldworld but not as good
  {"yorumicolors/yorumi.nvim",
  config = function()
    -- require('yorumi').setup()
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function(params)
        if params.match == "yorumi" then
          vim.api.nvim_set_hl(0, "SnacksIndent", {fg='#171922'})
          vim.api.nvim_set_hl(0, "SnacksIndentScope", {fg='#304595'})
          vim.api.nvim_set_hl(0, "Normal", {bg='#06080d'})
          vim.api.nvim_set_hl(0, "LspReferenceText", {bg='#172135'})
        end
      end,
    })
  end
}, -- nice, very dark.
  -- {"datsfilipe/vesper.nvim"},
  {"dgox16/oldworld.nvim"}, -- nice.
  -- {"xero/miasma.nvim"},
  -- {"vague2k/huez.nvim", enabled=false, config = function() require("huez").setup({}) end,},

	{
		"saghen/blink.cmp",
    -- enabled = false,
		opts = {
			keymap = {
				-- preset = "enter",
				-- ["<C-y>"] = { "select_and_accept" },
				preset = "cmdline",
				-- preset = "none",
				-- ["<CR>"] = {},
				["<C-CR>"] = { "select_and_accept" }, -- unforunately does not work with most terminals.
				["<C-Space>"] = { "show", "select_and_accept" },
			},
      completion = {
        ghost_text = { enabled = false },
        menu = { auto_show = false },
      }
		},
	},

	-- change some telescope options and a keymap to browse plugin files
	{
		"nvim-telescope/telescope.nvim",
		keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },

			{ "<leader>tt", function() require("telescope.builtin").builtin() end, desc = "Telescope Builtins", },
			{ "<leader>tr", function() require("telescope.builtin").resume() end, desc = "Telescope Resume", },
		},
		-- change some options
		opts = {
			defaults = {
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 0,
			},
		},
	},



    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            automatic_enable = false,
        },
        dependencies = {
            "mason-org/mason.nvim",
            {
                "neovim/nvim-lspconfig",
                opts = {
                    automatic_enable = false,
                    inlay_hints = { enabled = false },
                },
            },
        },
    },


  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "tokyonight-moon",
      -- colorscheme = "ayu-mirage",
      -- colorscheme = "kanagawa-paper",
      -- colorscheme = "rose-pine-main", -- its just the best!
      -- colorscheme = "oldworld",
      colorscheme = "yorumi",
    },
  },

}
