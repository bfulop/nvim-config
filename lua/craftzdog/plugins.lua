local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'nvim-lua/plenary.nvim'     -- Common utilities
  use 'onsails/lspkind-nvim'      -- vscode-like pictograms
  use 'hrsh7th/cmp-buffer'        -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp'      -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp'          -- Completion
  use 'neovim/nvim-lspconfig'     -- LSP
  use 'nvimtools/none-ls-extras.nvim'
  use { 'nvimtools/none-ls.nvim',
    requires = {
      "nvim-lua/plenary.nvim",
      "nvimtools/none-ls-extras.nvim",
    },
  } -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  -- use 'jose-elias-alvarez/typescript.nvim'
  use {
    "pmizio/typescript-tools.nvim",
    requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  }
  use 'dmmulroy/tsc.nvim'
  -- Lua
  use {
    "folke/trouble.nvim",
  }
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'daschw/leaf.nvim'
  use 'RRethy/nvim-treesitter-textsubjects'
  use 'echasnovski/mini.nvim'
  use 'glepnir/lspsaga.nvim' -- LSP UIs
  use 'L3MON4D3/LuaSnip'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-tree/nvim-web-devicons' -- File icons
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use { 'numToStr/Comment.nvim',
    requires = {
      'JoosepAlviste/nvim-ts-context-commentstring'
    }
  }
  use 'norcalli/nvim-colorizer.lua'
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use 'akinsho/nvim-bufferline.lua'
  -- highlight words
  use 'dvoytik/hi-my-words.nvim'
  -- use 'github/copilot.vim'

  use 'lewis6991/gitsigns.nvim'
  use 'dinhhuy258/git.nvim' -- For git blame & browse
  -- minimap
  use 'ziontee113/neo-minimap'
  -- For session management
  use 'olimorris/persisted.nvim'
  use 'ahmedkhalf/project.nvim'
  -- JSDoc comment
  -- use {
  --   "danymat/neogen",
  --   config = function()
  --     require('neogen').setup({})
  --   end,
  --   requires = "nvim-treesitter/nvim-treesitter",
  --   -- Uncomment next line if you want to follow only stable versions
  --   -- tag = "*"
  -- }
  use 'Exafunction/codeium.vim'
  use 'stevearc/oil.nvim'
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }
end)

require('Comment').setup()
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
require('tsc').setup({
  flags = {
    skipLibCheck = true
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
