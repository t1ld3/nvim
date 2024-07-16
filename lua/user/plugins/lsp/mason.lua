return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "cssls",
        "angularls",
        "asm_lsp",
        "awk_ls",
        "bashls",
        "clangd",
        "cmake",
        "csharp_ls",
        "cssls",
        "docker_compose_language_service",
        "dockerls",
        "eslint",
        "html",
        "jdtls",
        "jsonls",
        "lua_ls",
        "lua_ls",
        "omnisharp",
        "pyright",
        "rust_analyzer",
        "svelte",
        "tailwindcss",
        "texlab",
        "tsserver",
        "zk",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })
  end,
}
