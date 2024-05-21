local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "markdown",
    "markdown_inline",
    "typescript",
    "javascript",
    "tsx",
    "toml",
    "php",
    "json",
    "yaml",
    "swift",
    "scss",
    "css",
    "html",
    "lua"
  },
  textsubjects = {
    enable = true,
    prev_selection = ',', -- (Optional) keymap to select the previous selection
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
      ['i;'] = 'textsubjects-container-inner',
    },
  },
}
--
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "typescriptreact" }
--
--
-- vim.treesitter.set_query("javascript", "injections", "")
-- vim.treesitter.set_query("typescript", "injections", "")
-- vim.treesitter.set_query("tsx", "injections", "")
-- vim.treesitter.set_query("lua", "injections", "")
-- require 'vim.treesitter.query'.set_query("javascript", "injections", "");
-- require 'vim.treesitter.query'.set_query("typescript", "injections", "");
-- require 'vim.treesitter.query'.set_query("tsx", "injections", "");
-- require 'vim.treesitter.query'.set_query("lua", "injections", "");
