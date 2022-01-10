local files = {
	"options",
	"keymaps",
	"plugins",
	"colorscheme",
	"treesitter",
	"lsp",
	"cmp",
	"autopairs",
	"nvim-tree",
	"telescope",
	"comment",
	"gitsigns",
	"bufferline",
	"lualine",
	"project",
	"indentline",
	"alpha",
	"which-key",
	"toggleterm",
}
vim.opt.termguicolors = true
require("user.notify")
local status_ok, notify = pcall(require, "notify")
if status_ok then
	vim.notify = notify
for _, v in ipairs(files) do
	---@diagnostic disable-next-line: redefined-local
	local status_ok, _ = pcall(require, "user." .. v)
	if not status_ok then
		vim.notify(v .. ".lua not found!", vim.log.levels.ERROR)
	end
end
end
