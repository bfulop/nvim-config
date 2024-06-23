local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local fb_actions = require "telescope".extensions.file_browser.actions


telescope.setup {
  tiebreak = function() return false end,
  defaults = {
    border = true,
    winblend = 0,
    path_display = {
      truncate = 2
    },
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  },
  pickers = {
    current_buffer_fuzzy_find = {
      fzf_tiebreak = function(current_entry, existing_entry)
        return current_entry.lnum < existing_entry.lnum
      end
    }
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      border = true,
      respect_gitignore = true,
      display_stat = false,
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        -- your custom insert mode mappings
        ["i"] = {
          ["<C-w>"] = function() vim.cmd('normal vbd') end,
        },
        ["n"] = {
          -- your custom normal mode mappings
          ["o"] = require "telescope.actions".select_default,
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd('startinsert')
          end
        },
      },
    },
  },
}

telescope.load_extension("file_browser")

vim.keymap.set('n', '<Leader>f',
  function()
    builtin.find_files({
      respect_gitignore = true,
      no_ignore = false,
      hidden = false,
      path_display = {
        truncate = 2
      }
    })
  end)
vim.keymap.set('n', '<Leader>r', function()
  builtin.live_grep()
end)
vim.keymap.set('n', '<Leader>b', function()
  builtin.buffers({
    sort_mru = true
  })
end)
vim.keymap.set('n', '<Leader>t', function()
  builtin.help_tags()
end)
vim.keymap.set('n', '<Leader>;', function()
  builtin.resume()
end)
vim.keymap.set('n', '<Leader>e', function()
  builtin.diagnostics()
end)
vim.keymap.set("n", "sf", function()
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = true,
    hidden = false,
    grouped = true,
    theme = "ivy",
    initial_mode = "normal",
  })
end)

vim.keymap.set('n', '<Leader>se', ':Telescope persisted<CR>', { noremap = true })
