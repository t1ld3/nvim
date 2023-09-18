local base = {
  "autocommands",
  "options",
  "keymaps",
  "plugins",
  "colorscheme",
  "lsp",
}
vim.opt.termguicolors = true
for _, v in ipairs(base) do
  local status_ok, err = pcall(require, "user." .. v)
  if not status_ok then
    vim.notify(v .. ".lua: " .. err, vim.log.levels.ERROR)
  end
end
