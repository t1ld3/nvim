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
  local status_ok, _ = pcall(require, "user." .. v)
  if not status_ok then
    vim.notify("Error: missing file: '" .. v .. ".lua'", vim.log.levels.ERROR)
  end
end
