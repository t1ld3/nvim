return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  version = "2.1.0",
  config = function()
    local which_key = require("which-key")

    local setup = {
      plugins = {
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
          operators = false,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
          motions = false,      -- adds help for motions
          text_objects = false, -- help for text objects triggered after entering an operator
          windows = false,      -- default bindings on <c-w>
          nav = false,          -- misc bindings to work with windows
          z = true,             -- bindings for folds, spelling and others prefixed with z
          g = true,             -- bindings for prefixed with g
        },
      },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
      },
      window = {
        border = "rounded",       -- none, single, double, shadow
        position = "bottom",      -- bottom, top
        margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
        padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
        zindex = 1000,            -- positive value to position WhichKey above other floating windows.
      },
      ignore_missing = true,      -- enable this to hide mappings for which you didn't specify a label
      disable = {
        filetypes = { "alpha" },
      },
    }

    local opts = {
      mode = "n",
      prefix = "<leader>",
      buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true,  -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true,  -- use `nowait` when creating keymaps
    }

    local mappings = {
      ["n"] = { "<cmd>NvimTreeToggle<CR>", "File tree" },
      ["w"] = { "<cmd>w!<CR>", "Save" },
      ["q"] = { "<cmd>qa<CR>", "Quit" },
      ["c"] = { "<cmd>bwipeout<CR>", "Close Buffer" },
      ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
      p = {
        name = "Plugins",
        c = { "<cmd>Lazy build<cr>", "Build" },
        i = { "<cmd>Lazy install<cr>", "Install" },
        s = { "<cmd>Lazy sync<cr>", "Sync" },
        S = { "<cmd>Lazy<cr>", "Status" },
        u = { "<cmd>Lazy update<cr>", "Update" },
      },
      g = {
        name = "Git",
        g = { function() _LAZYGIT_TOGGLE() end, "Lazygit" },
        j = { function() require('gitsigns').next_hunk() end, "Next Hunk" },
        k = { function() require('gitsigns').prev_hunk() end, "Prev Hunk" },
        l = { function() require('gitsigns').blame_line() end, "Blame" },
        p = { function() require('gitsigns').preview_hunk() end, "Preview Hunk" },
        r = { function() require('gitsigns').reset_hunk() end, "Reset Hunk" },
        R = { function() require('gitsigns').reset_buffer() end, "Reset Buffer" },
        s = { function() require('gitsigns').stage_hunk() end, "Stage Hunk" },
        S = { function() require('gitsigns').stage_buffer() end, "Stage Hunk" },
        u = { function() require('gitsigns').undo_stage_hunk() end, "Undo Stage Hunk" },
        o = { function() require('telescope.builtin').git_status() end, "Open changed file" },
        b = { function() require('telescope.builtin').git_branches() end, "Checkout branch" },
        c = { function() require('telescope.builtin').git_commits() end, "Checkout commit" },
        C = { function() require('telescope').extensions.gitmoji.gitmoji() end, "Commit with gitmoji" },
        d = { function() require('gitsigns').diffthis({ "HEAD" }) end, "Diff" },
      },
      l = {
        name = "Lsp",
        a = { function() vim.lsp.buf.code_action() end, "Code Action" },
        d = { function() require('telescope').builtin.diagnostics() end, "Workspace Diagnostics" },
        f = { function() vim.lsp.buf.format({ async = true }) end, "Format" },
        i = { function() vim.cmd("LspInfo") end, "Info" },
        I = { function() vim.cmd("Mason") end, "Installer Info" },
        j = { function() vim.diagnostic.goto_next({ border = 'rounded' }) end, "Next Diagnostic" },
        k = { function() vim.diagnostic.goto_prev({ border = 'rounded' }) end, "Prev Diagnostic" },
        l = { function() vim.lsp.codelens.run() end, "CodeLens Action" },
        q = { function() vim.diagnostic.setloclist() end, "Quickfix" },
        r = { function() vim.lsp.buf.rename() end, "Rename" },
        s = { function() require('telescope.builtin').lsp_document_symbols() end, "Document Symbols" },
        S = { function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end, "Workspace Symbols" },
      },
      d = {
        name = "Debugger",
        c = { function() require('dap').continue() end, "Continue" },
        h = { function() require('dap').step_hover() end, "Step hover" },
        i = { function() require('dap').step_into() end, "Step into" },
        o = { function() require('dap').step_out() end, "Step out" },
        b = { function() require('dap').toggle_breakpoint() end, "Toggle breakpoint" },
        B = { function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, "Set breakpoint" },
        l = { function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, "Set log breakpoint" },
        r = { function() require('dap').repl.open() end, "Open repl" }
      },
      s = {
        name = "Search",
        b = { function() require('telescope.builtin').git_branches() end, "Checkout branch" },
        h = { function() require('telescope.builtin').help_tags() end, "Find help" },
        M = { function() require('telescope.builtin').man_pages() end, "Man pages" },
        r = { function() require('telescope.builtin').oldfiles() end, "Open recent file" },
        R = { function() require('telescope.builtin').registers() end, "Registers" },
        m = { function() require('telescope.builtin').media_files() end, "Media Files" },
      },
      t = {
        name = "Terminal",
        n = { function() _NODE_TOGGLE() end, "Node" },
        u = { function() _NCDU_TOGGLE() end, "NCDU" },
        t = { function() _HTOP_TOGGLE() end, "Htop" },
        p = { function() _PYTHON_TOGGLE() end, "Python" },
        f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
        h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
        v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
      },
    }

    which_key.setup(setup)
    which_key.register(mappings, opts)
  end
}
