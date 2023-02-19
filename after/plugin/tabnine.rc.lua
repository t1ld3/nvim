require('tabnine').setup({
  disable_auto_comment = true,
  accept_keymap = "<C-b>",
  dismiss_keymap = "<C-x>",
  debounce_ms = 800,
  suggestion_color = { gui = "#808080", cterm = 244 },
  execlude_filetypes = { "TelescopePrompt" }
})
