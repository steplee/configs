return {
  { "folke/noice.nvim", enabled = false },
  { "folke/flash.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  {"echasnovski/mini.pairs", enabled=false},

  -- indent is broken for me.
  {
  "nvim-treesitter/nvim-treesitter",
    opts = { indent = { enable = false} },
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = false },
      -- statuscolumn = { enabled = true },
      statuscolumn = { enabled = false },
      words = { enabled = true },
      scratch = {enabled=false},
      terminal = {
        win={style="float"},
      },
      indent = {
        enabled = true,
        animate = {enabled=false},
        chunk={enabled=false},
      },
    },
    keys = {
    }
  },


}
