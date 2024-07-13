return {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
  config = function()
    local mason_nvim_dap = require("mason-nvim-dap")
    mason_nvim_dap.setup(
      {
        ensure_installed = {
          "chrome-debug-adapter",
          "cpptools",
          "codelldb",
          "delve",
          "js-debug-adapter",
        },
        automatic_installation = true,
        handlers = {
          function(config)
            mason_nvim_dap.default_setup(config)
          end,
          codelldb = function(config)
            config.configurations = {
              {
                name = 'LLDB: Launch',
                type = 'codelldb',
                request = 'launch',
                program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},
                console = 'integratedTerminal',
              },
              {
                name = 'LLDB: Launch with command line arguments',
                type = 'codelldb',
                request = 'launch',
                program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = function()
                  local input = vim.fn.input('Command-line arguments: ', 'file')
                  local arguments = {}
                  for argument in input:gmatch("%S+") do table.insert(arguments, argument) end
                  return arguments
                end,
                console = 'integratedTerminal',
              },
            }
            mason_nvim_dap.default_setup(config)
          end
        }, -- 	- {adapters: function(default), configurations: function(default), filetypes: function(default), }. Allows modifying the default configuration passed in via function.
      }
    )
  end
}
