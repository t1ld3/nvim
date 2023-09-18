local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use("wbthomason/packer.nvim")              -- Have packer manage itself
  use("nvim-lua/plenary.nvim")               -- Useful lua functions used ny lots of plugins
  use("windwp/nvim-autopairs")               -- Autopairs, integrates with both cmp and treesitter
  use("windwp/nvim-ts-autotag")              -- auto close html tags
  use("numToStr/Comment.nvim")               -- Easily comment stuff
  use("nvim-lualine/lualine.nvim")           -- statusline
  use("akinsho/toggleterm.nvim")             -- terminal handler
  use("lukas-reineke/indent-blankline.nvim") -- indetation lines
  use("goolord/alpha-nvim")
  use("folke/which-key.nvim")
  use("tpope/vim-surround")
  use("RRethy/vim-illuminate")
  use("ahmedkhalf/project.nvim")
  use('ThePrimeagen/refactoring.nvim')
  use('christoomey/vim-tmux-navigator')

  use("onsails/lspkind-nvim")
  use("nvim-tree/nvim-web-devicons")
  use("nvim-tree/nvim-tree.lua")
  use('stevearc/dressing.nvim')
  -- Colorschemes
  use('savq/melange')
  use('ellisonleao/gruvbox.nvim')

  -- cmp plugins
  use("hrsh7th/nvim-cmp")         -- The completion plugin
  use("hrsh7th/cmp-buffer")       -- buffer completions
  use("hrsh7th/cmp-path")         -- path completions
  use("hrsh7th/cmp-cmdline")      -- cmdline completions
  use("saadparwaiz1/cmp_luasnip") -- snippet completions
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  --[[ use { "codota/tabnine-nvim", run = "./dl_binaries.sh" } ]]
  -- snippets
  use("L3MON4D3/LuaSnip")             --snippet engine
  use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

  -- LSP
  use("neovim/nvim-lspconfig") -- enable LSP
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
  -- DAP
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
  use("jay-babu/mason-nvim-dap.nvim")
  use("nvim-telescope/telescope-dap.nvim")
  use("theHamsta/nvim-dap-virtual-text")


  -- Telescope
  use("nvim-telescope/telescope.nvim")
  use("nvim-telescope/telescope-media-files.nvim")
  use('nvim-telescope/telescope-ui-select.nvim')
  use("nvim-telescope/telescope-file-browser.nvim")
  use('olacin/telescope-gitmoji.nvim')

  -- TreeSitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function() require("nvim-treesitter.install").update({ with_sync = true }) end,
  })
  use("p00f/nvim-ts-rainbow")
  use("nvim-treesitter/playground")

  use("JoosepAlviste/nvim-ts-context-commentstring")

  -- Git
  use("lewis6991/gitsigns.nvim")
  use("dinhhuy258/git.nvim")

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
