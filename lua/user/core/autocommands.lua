local augroup = vim.api.nvim_create_augroup("default_group", { clear = true })
vim.api.nvim_create_autocmd({ "VimResized" }, { group = augroup, callback = function() vim.cmd "tabdo wincmd =" end })
-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup,
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<cr>", { silent = true, buffer = true })
    vim.opt_local.buflisted = false
  end,
})
-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup,
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup,
  pattern = { "make" },
  callback = function()
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 0
  end
})
vim.api.nvim_create_autocmd({ "BufEnter" },
  {
    group = augroup,
    callback = function() vim.cmd "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif" end
  })
-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  group = augroup,
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})
-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = augroup,
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})
