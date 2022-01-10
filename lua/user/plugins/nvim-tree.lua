return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nvim_tree = require("nvim-tree")

    local function nvim_tree_on_attach(bufnr)
      local api = require('nvim-tree.api')

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      api.config.mappings.default_on_attach(bufnr)

      -- disable editing keymaps
      vim.keymap.set('n', 'O', '', { buffer = bufnr })
      vim.keymap.del('n', 'O', { buffer = bufnr })
      vim.keymap.set('n', '<2-RightMouse>', '', { buffer = bufnr })
      vim.keymap.del('n', '<2-RightMouse>', { buffer = bufnr })
      vim.keymap.set('n', 'D', '', { buffer = bufnr })
      vim.keymap.del('n', 'D', { buffer = bufnr })
      vim.keymap.set('n', 'E', '', { buffer = bufnr })
      vim.keymap.del('n', 'E', { buffer = bufnr })

      -- custom keymaps
      vim.keymap.set('n', '<cr>', api.node.open.edit, opts("Edit"))
      vim.keymap.set('n', 'v', api.node.open.vertical, opts("vsplit"))
      vim.keymap.set('n', 'A', api.tree.expand_all, opts('Expand All'))
      vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
      vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts('CD'))

      vim.keymap.set('n', 'Z', api.node.run.system, opts('Run System'))
    end

    nvim_tree.setup({
      on_attach = nvim_tree_on_attach,
      disable_netrw = true,
      hijack_netrw = true,
      sort_by = "name",
      sync_root_with_cwd = true,
      view = {
        width = 35,
      },
      renderer = {
        icons = {
          glyphs = {
            default = "",
            symlink = "",
            folder = {
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
            },
            git = {
              unstaged = "",
              staged = "S",
              unmerged = "",
              renamed = "➜",
              deleted = "",
              untracked = "U",
              ignored = "◌",
            },
          },
        },
      },
      update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = {},
      },
      diagnostics = {
        enable = true,
        show_on_dirs = false,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      filters = {
        dotfiles = false,
        custom = {},
        exclude = {},
      },
      git = {
        enable = true,
        timeout = 500,
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        open_file = {
          quit_on_open = true,
          resize_window = true,
          window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          diagnostics = false,
          git = false,
          profile = false,
        },
      },
    })
  end
}
