return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require('refactoring').setup({
      prompt_func_return_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      prompt_func_param_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      printf_statements = {},
      print_var_statements = {},
    })
    local which_key = require('which-key')
    local opts = {
      mode = { "n", "x" },
      prefix = "<leader>",
      buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true,  -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true,  -- use `nowait` when creating keymaps
    }

    local keymaps = {
      ["r"] = { function() require('telescope').extensions.refactoring.refactors() end, "Refactors" }
    }

    which_key.register(keymaps, opts)
  end
}
