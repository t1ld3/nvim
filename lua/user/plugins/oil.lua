return {
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/which-key.nvim",
  },
  config = function()
    require("oil").setup()
    local which_key = require("which-key")

    local opts = {
      mode = "n",     -- NORMAL mode
      prefix = "<leader>",
      buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true,  -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true,  -- use `nowait` when creating keymaps
    }
    local mappings = {
      ["-"] = { "<CMD>Oil<CR>", "Open parent directory" },
    }

    which_key.register(mappings, opts)
  end
}
