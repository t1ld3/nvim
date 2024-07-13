return {
  "akinsho/toggleterm.nvim",
  config = function()
    local toggleterm = require("toggleterm")

    toggleterm.setup({
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 1,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    })

    local function set_terminal_keymaps()
      local opts = { noremap = true, buffer = true }
      local set = vim.keymap.set
      set("t", "<esc>", [[<C-\><C-n>]], opts)
      set("t", "jk", [[<C-\><C-n>]], opts)
      set("t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
      set("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
      set("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
      set("t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
    end

    vim.api.nvim_create_autocmd({ "TermOpen" }, {
      group = vim.api.nvim_create_augroup("TermToggleKeymaps", { clear = true }),
      pattern = { "term://*" },
      callback = set_terminal_keymaps,
    })

    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

    function _LAZYGIT_TOGGLE()
      lazygit:toggle()
    end

    local node = Terminal:new({ cmd = "node", hidden = true })

    function _NODE_TOGGLE()
      node:toggle()
    end

    local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })

    function _NCDU_TOGGLE()
      ncdu:toggle()
    end

    local htop = Terminal:new({ cmd = "htop", hidden = true })

    function _HTOP_TOGGLE()
      htop:toggle()
    end

    local python = Terminal:new({ cmd = "python", hidden = true })

    function _PYTHON_TOGGLE()
      python:toggle()
    end
  end
}
