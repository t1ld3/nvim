local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  vim.notify("error, lspconfig not installed", vim.log.levels.ERROR)
  return
end

local opts = {
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
}

local jsonls_opts = require("user.lsp.settings.jsonls")
local jsonls_ls_opts = vim.tbl_deep_extend("force", jsonls_opts, opts)

lspconfig.jsonls.setup(jsonls_ls_opts)

local sumneko_opts = require("user.lsp.settings.sumneko_lua")
local lua_ls_opts = vim.tbl_deep_extend("force", sumneko_opts, opts)

lspconfig.lua_ls.setup(lua_ls_opts)

local clangd_opts = require("user.lsp.settings.clangd")
local clangd_ls_opts = vim.tbl_deep_extend("force", clangd_opts, opts)

lspconfig.clangd.setup(clangd_ls_opts)

local omnisharp_opts = require("user.lsp.settings.omnisharp")
local omnisharp_ls_opts = vim.tbl_deep_extend("force", omnisharp_opts, opts)

lspconfig.omnisharp.setup(omnisharp_ls_opts)
