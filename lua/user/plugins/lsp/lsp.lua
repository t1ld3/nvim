return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "RRethy/vim-illuminate",
    "hrsh7th/nvim-cmp",
    { "j-hui/fidget.nvim", opts = {} },
    'stevearc/conform.nvim',
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local servers = {
      "jsonls",
      "lua_ls",
      "clangd",
      "dockerls",
      "docker_compose_language_service",
      "jdtls",
      "eslint",
      "tsserver",
      "rust_analyzer",
      "bashls",
      "html",
      "zk",
      "texlab",
      "cssls",
      "csharp_ls",
      "angularls",
      "pyright",
      "asm_lsp",
      "awk_ls",
    }

    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities.textDocument.completion.completionItem.snippetSupport = true

    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    local conform = require('conform')

    conform.setup({
      formatters_by_ft = {
        python = { "black" },
        javascript = { "prettier" },
      },
      formatters = {
        black = {
          args = { "--fast" },
        },
        prettier = {
          args = { "--no-semi", "--single-quote", "--jsx-single-quote" }
        }
      }
    })

    local augroup_format = vim.api.nvim_create_augroup("LSP_Format", { clear = true })
    local function create_format_autocmd(bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup_format,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end

    local function enable_format_on_save(_, bufnr)
      vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
      create_format_autocmd(bufnr)
    end

    local function toggle_format_on_save(_, bufnr)
      local match = vim.api.nvim_get_autocmds({ group = augroup_format, event = "BufWritePre", buffer = bufnr })
      if #match ~= 0 then
        vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
        vim.print("Toggled lsp formatting off")
      else
        create_format_autocmd(bufnr)
        vim.print("Toggled lsp formatting on")
      end
    end

    local function lsp_keymaps(_, bufnr)
      local opts = { buffer = bufnr, noremap = true, silent = true }
      local map = vim.keymap.set
      map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
      map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
      map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
      map("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
      map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
      map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
      map("n", "gl", '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", border = "single" })<CR>', opts)
      map("n", "<leader>lt", toggle_format_on_save, opts)
      vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({async=true})' ]])
    end

    local lspconfig = require("lspconfig")

    local on_attach = function(client, bufnr)
      lsp_keymaps(client, bufnr)
      enable_format_on_save(client, bufnr)
      local status_ok, illuminate = pcall(require, "illuminate")
      if not status_ok then
        return
      end
      illuminate.on_attach(client)
    end

    for _, server in pairs(servers) do
      local opts = {
        on_attach = on_attach,
        capabilities = capabilities
      }
      local require_ok, conf_opts = pcall(require, "user.plugins.lsp.settings." .. server)
      if require_ok then
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
      end
      lspconfig[server].setup(opts)
    end

    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local config = {
      virtual_text = {
        prefix = '●'
      },
      signs = {
        active = signs, -- show signs
      },
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = '●' },
        severity_sort = true,
      }
    )

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
    })
  end
}
