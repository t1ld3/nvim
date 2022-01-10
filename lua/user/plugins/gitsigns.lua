return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "folke/which-key.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local gitsigns = require("gitsigns")

    --[[ vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'GitSignsAdd' }) ]]
    gitsigns.setup({
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
      },
      signs_staged = {
        add          = { text = "" },
        change       = { text = "" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "" },
        untracked    = { text = "" },

      },
      attach_to_untracked = true,
    })
  end
}
