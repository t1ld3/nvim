return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-media-files.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "olacin/telescope-gitmoji.nvim",
    "nvim-telescope/telescope-dap.nvim",
    "folke/which-key.nvim",
  },
  config = function()
    local telescope = require("telescope")

    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-j>"] = actions.cycle_history_next,
            ["<C-k>"] = actions.cycle_history_prev,
            ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
          },
          n = {
            ["q"] = actions.close,
            ["?"] = actions.which_key,
          },
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          previewer = false,
          command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
      extensions = {
        media_files = {
          filetypes = { "png", "webp", "mp4", "jpg", "jpeg", "pdf" },
          find_cmd = "find",
        },
        file_browser = {
          theme = "ivy",
          hijack_netrw = true,
          respect_gitignore = false,
          hidden = true,
          grouped = true,
        },
        gitmoji = {
          action = function(entry)
            local emoji = entry.value.value
            vim.ui.input({ prompt = "Enter commit message: " .. emoji .. " " }, function(msg)
              if not msg then
                return
              end
              -- Insert text instead of emoji in message
              local emoji_text = entry.value.text
              vim.cmd(':!git commit -m "' .. emoji_text .. ' ' .. msg .. '"')
            end)
          end,
        },
      },
    })
    telescope.load_extension("ui-select")
    telescope.load_extension("file_browser")
    telescope.load_extension('media_files')
    telescope.load_extension("gitmoji")
    telescope.load_extension("refactoring")
    telescope.load_extension("dap")

    local which_key = require('which-key')
    local builtin = require('telescope.builtin')
    local opts = {
      mode = "n",
      prefix = "<leader>",
      buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true,  -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true,  -- use `nowait` when creating keymaps
    }
    local mappings = {
      ["b"] = { function() builtin.buffers(require('telescope.themes').get_dropdown { previewer = false }) end, "Buffers" },
      ["f"] = { function() builtin.find_files(require('telescope.themes').get_dropdown { previewer = false }) end, "Find files" },
      ["F"] = { function() builtin.live_grep(require('telescope.themes').get_ivy({})) end, "Find Text" },
      ["e"] = { function() telescope.extensions.file_browser.file_browser() end, "Explorer" },
      ["P"] = { function() telescope.extensions.projects.projects() end, "Projects" },
    }
    which_key.register(mappings, opts)
  end
}
