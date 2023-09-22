return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "nvim-treesitter/playground",
    "JoosepAlviste/nvim-ts-context-commentstring" },
  event = { "BufReadPre", "BufNewFile" },
  build = function() require("nvim-treesitter.install").update({ with_sync = true }) end,
  config = function()
    require("nvim-treesitter.configs").setup({
      -- A list of parser names, or "all"
      ensure_installed = { "c", "cpp", "haskell", "markdown", "typescript", "html", "css", "sql", "css", "lua",
        "python", "go", "ruby", "vim", "vimdoc", "javascript", "rust", "zig", "bash", "dockerfile", "markdown_inline",
        "doxygen" },
      -- Install languages synchronously (only applied to `ensure_installed`)
      sync_install = false,
      -- List of parsers to ignore installing
      ignore_install = {},
      autopairs = { enable = false },
      highlight = {
        -- `false` will disable the whole extension
        enable = true,
        -- list of language that will be disabled
        disable = { "python" },
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true, disable = { "yaml" } },
      playground = {
        enable = false,
        disable = {},
        updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
    })
  end
}
