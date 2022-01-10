return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn" },
      symbols = { error = " ", warn = " " },
      colored = true,
      update_in_insert = true,
      always_visible = true,
    }

    local diff = {
      "diff",
      colored = true,
      symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
      cond = hide_in_width,
    }

    local filetype = {
      "filetype",
      icons_enabled = true,
      icon = nil,
    }

    local branch = {
      "branch",
      icons_enabled = true,
      icon = "",
    }

    local location = {
      "location",
      padding = 0,
    }

    local filename = {
      'filename',
      file_status = true,
      path = 1,
      symbols = {
        modified = '●', -- Text to show when the file is modified.
        readonly = '', -- Text to show when the file is non-modifiable or readonly.
        unnamed = '', -- Text to show for unnamed buffers.
        newfile = '[New]',
      }
    }

    local spaces = function()
      return "shiftwidth: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
    end

    lualine.setup({
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { branch, diff },
        lualine_c = { diagnostics, filename },
        lualine_x = { spaces, "encoding", "fileformat", filetype },
        lualine_y = { 'progress' },
        lualine_z = { location },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { " filename", file_status = true, path = 2 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    })
  end
}
