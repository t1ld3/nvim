return {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
  config = function()
    local mason_nvim_dap = require("mason-nvim-dap")
    local DEFAULT_SETTINGS = {
      -- A list of adapters to install if they're not already installed.
      -- This setting has no relation with the `automatic_installation` setting.
      ensure_installed = {
        "chrome-debug-adapter",
        "cpptools",
        "codelldb",
        "delve",
        "js-debug-adapter",
      },
      -- NOTE: this is left here for future porting in case needed
      -- Whether adapters that are set up (via dap) should be automatically installed if they're not already installed.
      -- This setting has no relation with the `ensure_installed` setting.
      -- Can either be:
      --   - false: Daps are not automatically installed.
      --   - true: All adapters set up via dap are automatically installed.
      --   - { exclude: string[] }: All adapters set up via mason-nvim-dap, except the ones provided in the list, are automatically installed.
      --       Example: automatic_installation = { exclude = { "python", "delve" } }
      automatic_installation = true,
      -- See below on usage
      handlers = {
        function(config)
          mason_nvim_dap.default_setup(config)
        end
      }, -- 	- {adapters: function(default), configurations: function(default), filetypes: function(default), }. Allows modifying the default configuration passed in via function.
    }
    mason_nvim_dap.setup(DEFAULT_SETTINGS)
  end
}
