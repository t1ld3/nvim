return {
  settings = {

    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          unpack(vim.api.nvim_get_runtime_file("", true)),
          vim.fn.stdpath("config") .. "/lua",
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
