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
  -- Packer
  use "sindrets/diffview.nvim"
  use {
    'harrisoncramer/gitlab.nvim',
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim"
    },
    run = function() require("gitlab.server").build(true) end,
  }
end)

require('Comment').setup()
require("persisted").setup({ silent = false })
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

require("gitlab").setup({
  port = nil,                                               -- The port of the Go server, which runs in the background, if omitted or `nil` the port will be chosen automatically
  log_path = vim.fn.stdpath("cache") .. "/gitlab.nvim.log", -- Log path for the Go server
  debug = { go_request = false, go_response = false },      -- Which values to log
  reviewer = "diffview",                                    -- The reviewer type ("delta" or "diffview")
  attachment_dir = nil,                                     -- The local directory for files (see the "summary" section)
  popup = {
    -- The popup for comment creation, editing, and replying
    exit = "<Esc>",
    perform_action = "<leader>s",          -- Once in normal mode, does action (like saving comment or editing description, etc)
    perform_linewise_action = "<leader>l", -- Once in normal mode, does the linewise action (see logs for this job, etc)
  },
  discussion_tree = {
    -- The discussion tree that holds all comments
    blacklist = {},         -- List of usernames to remove from tree (bots, CI, etc)
    jump_to_file = "o",     -- Jump to comment location in file
    jump_to_reviewer = "m", -- Jump to the location in the reviewer window
    edit_comment = "e",     -- Edit coment
    delete_comment = "dd",  -- Delete comment
    reply = "r",            -- Reply to comment
    toggle_node = "t",      -- Opens or closes the discussion
    toggle_resolved = "p",  -- Toggles the resolved status of the discussion
    position = "left",      -- "top", "right", "bottom" or "left"
    size = "20%",           -- Size of split
    relative = "editor",    -- Position of tree split relative to "editor" or "window"
    resolved = '✓',       -- Symbol to show next to resolved discussions
    unresolved = '✖',     -- Symbol to show next to unresolved discussions
  },
  pipeline = {
    created = "",
    pending = "",
    preparing = "",
    scheduled = "",
    running = "ﰌ",
    canceled = "ﰸ",
    skipped = "ﰸ",
    success = "✓",
    failed = "",
  },
})
