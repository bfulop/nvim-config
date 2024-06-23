local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

local function is_not_vscode()
  return not vim.g.vscode
end



packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use { 'nvim-lualine/lualine.nvim', cond = is_not_vscode } -- Statusline
  use { 'nvim-lua/plenary.nvim', cond = is_not_vscode }     -- Common utilities
  use { 'onsails/lspkind-nvim', cond = is_not_vscode }      -- vscode-like pictograms
  use { 'hrsh7th/cmp-buffer', cond = is_not_vscode }        -- nvim-cmp source for buffer words
  use { 'hrsh7th/cmp-nvim-lsp', cond = is_not_vscode }      -- nvim-cmp source for neovim's built-in LSP
  use { 'hrsh7th/nvim-cmp', cond = is_not_vscode }          -- Completion
  use {
    'neovim/nvim-lspconfig',
    cond = is_not_vscode,
  }
  use { 'nvimtools/none-ls-extras.nvim', cond = is_not_vscode }
  use { 'nvimtools/none-ls.nvim',
    cond = is_not_vscode,
    requires = {
      "nvim-lua/plenary.nvim",
      "nvimtools/none-ls-extras.nvim",
    },
  } -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  -- use 'jose-elias-alvarez/typescript.nvim'
  use {
    "pmizio/typescript-tools.nvim",
    cond = is_not_vscode,
    requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  }
  use { 'dmmulroy/tsc.nvim', cond = is_not_vscode }
  -- Lua
  use {
    "folke/trouble.nvim",
    cond = is_not_vscode,
  }
  use { 'williamboman/mason.nvim', cond = is_not_vscode }
  use { 'williamboman/mason-lspconfig.nvim', cond = is_not_vscode }
  use { 'daschw/leaf.nvim'}
  use { 'RRethy/nvim-treesitter-textsubjects', cond = is_not_vscode }
  use { 'echasnovski/mini.nvim', cond = is_not_vscode }
  use { 'glepnir/lspsaga.nvim', cond = is_not_vscode } -- LSP UIs
  use { 'L3MON4D3/LuaSnip', cond = is_not_vscode }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    cond = is_not_vscode
  }
  use { 'nvim-tree/nvim-web-devicons', cond = is_not_vscode } -- File icons
  use { 'nvim-telescope/telescope.nvim', cond = is_not_vscode }
  use { 'nvim-telescope/telescope-file-browser.nvim', cond = is_not_vscode }
  use { 'windwp/nvim-autopairs', cond = is_not_vscode }
  use { 'windwp/nvim-ts-autotag', cond = is_not_vscode }
  use {
    "jellydn/typecheck.nvim",
    requires = {
      { "folke/trouble.nvim", requires = { "nvim-tree/nvim-web-devicons" } }
    },
    ft = { "javascript", "javascriptreact", "json", "jsonc", "typescript", "typescriptreact" },
    cond = is_not_vscode,
    config = function()
      require("typecheck").setup {
        debug = true,
        mode = "trouble", -- "quickfix" | "trouble"
      }
      vim.api.nvim_set_keymap("n", "<leader>ck", "<cmd>Typecheck<cr>",
        { noremap = true, silent = true, desc = "Run Type Check" })
    end
  }
  use { 'norcalli/nvim-colorizer.lua', cond = is_not_vscode }
  use({
    "iamcco/markdown-preview.nvim",
    cond = is_not_vscode,
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use { 'akinsho/nvim-bufferline.lua', cond = is_not_vscode }
  -- highlight words
  use { 'dvoytik/hi-my-words.nvim', cond = is_not_vscode }
  -- use 'github/copilot.vim'

  use { 'lewis6991/gitsigns.nvim', cond = is_not_vscode }
  use { 'dinhhuy258/git.nvim', cond = is_not_vscode } -- For git blame & browse
  -- minimap
  use { 'ziontee113/neo-minimap', cond = is_not_vscode }
  -- For session management
  use { 'olimorris/persisted.nvim', cond = is_not_vscode }
  use { 'Exafunction/codeium.vim', cond = is_not_vscode }
  use { 'stevearc/oil.nvim', cond = is_not_vscode }
  use {
    "nvim-neo-tree/neo-tree.nvim",
    cond = is_not_vscode,
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }
end)

-- require('Comment').setup()
require("persisted").setup({ silent = false, use_git_branch = true })
require("telescope").load_extension("persisted") -- To load the telescope extension
-- require('mini.animate').setup()
-- require('neogen').setup({})
require("oil").setup()
require("hi-my-words").setup({})
require("neo-tree").setup({
  enable_git_status = false,
  enable_diagnostics = false,
  close_if_last_window = true,
  -- sources = { "document_symbols" },
  default_component_configs = {
    indent = {
      indent_size = 2,
      with_markers = false,
    }
  },
  filesystem = {
    follow_current_file = true,
    filtered_items = {
      hide_by_pattern = { '*.lock' }
    }
  },
  buffers = {
    follow_current_file = true,
  },
  window = {
    position = "right",
    width = 50,
  }
})

require("typescript-tools").setup {
  settings = {
    -- spawn additional tsserver instance to calculate diagnostics on it
    separate_diagnostic_server = false,
    -- "change"|"insert_leave" determine when the client asks the server about diagnostic
    publish_diagnostic_on = "insert_leave",
    -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
    -- (see 💅 `styled-components` support section)
    tsserver_plugins = {
      "@styled/typescript-styled-plugin",
    },
    -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
    -- memory limit in megabytes or "auto"(basically no limit)
    tsserver_max_memory = "auto",
    -- described below
    tsserver_format_options = {},
    tsserver_file_preferences = {},
  },
}

require('tsc').setup({
  flags = {
    skipLibCheck = true,
    use_trouble_qflist = true,
  }
})

-- require('typecheck').setup {
--   debug = true,
--   mode = "trouble", -- "quickfix" | "trouble"
-- }
