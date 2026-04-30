-- Bootstrap mini.nvim ---------------------------------------------------------
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'

if not vim.uv.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    -- Uncomment next line to use 'stable' branch
    -- '--branch', 'stable',
    'https://github.com/echasnovski/mini.nvim', mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
end

require('mini.ai').setup({ n_lines = 1000 })
require('mini.surround').setup({ n_lines = 1000 })
require('mini.pick').setup()
require('mini.git').setup()

-- Git change markers ---------------------------------------------------------
-- mini.diff shows added/changed/deleted hunks compared to the Git index.
-- This keeps Git integration lightweight while still giving gutter markers.
require('mini.diff').setup({
  view = {
    style = 'sign',
    signs = {
      add = '+',
      change = '~',
      delete = '_',
    },
  },
})

-- Fuzzy file picker ----------------------------------------------------------
-- Uses mini.pick, which is already available through mini.nvim above.
-- <leader>ff works everywhere. <D-p> works in GUI Neovim clients that forward
-- the macOS Command key to Neovim; many terminal emulators reserve Cmd+P.
vim.keymap.set('n', '<leader>ff', '<cmd>Pick files<cr>', {
  desc = 'Find files',
})

vim.keymap.set('n', '<leader>gc', function()
  local git_root = vim.fn.systemlist({ 'git', 'rev-parse', '--show-toplevel' })[1]

  if vim.v.shell_error ~= 0 or git_root == nil or git_root == '' then
    vim.notify('Not inside a Git repository', vim.log.levels.WARN)
    return
  end

  local output = vim.fn.systemlist({ 'git', '-C', git_root, 'status', '--short' })

  if vim.v.shell_error ~= 0 then
    vim.notify('Could not read Git status', vim.log.levels.WARN)
    return
  end

  local items = {}

  for _, line in ipairs(output) do
    local path = line:sub(4)
    local renamed_path = path:match('^.* %-> (.*)$')

    if renamed_path ~= nil then
      path = renamed_path
    end

    if path ~= '' then
      table.insert(items, path)
    end
  end

  if #items == 0 then
    vim.notify('No changed files', vim.log.levels.INFO)
    return
  end

  MiniPick.start({
    source = {
      name = 'Git changed files',
      items = items,
      choose = function(item)
        local full_path = vim.fs.joinpath(git_root, item)
        local target_window = MiniPick.get_picker_state().windows.target

        vim.api.nvim_win_call(target_window, function()
          vim.cmd.edit(vim.fn.fnameescape(full_path))
        end)
      end,
    },
  })
end, {
  desc = 'Pick Git changed files',
})

vim.keymap.set('n', '<leader>go', function()
  require('mini.diff').toggle_overlay(0)
end, {
  desc = 'Toggle Git diff overlay',
})

vim.keymap.set('n', '<leader>fb', '<cmd>Pick buffers<cr>', {
  desc = 'Find open buffers',
})

vim.keymap.set('n', '<leader>fg', '<cmd>Pick grep_live<cr>', {
  desc = 'Live grep',
})

vim.keymap.set('n', '<D-p>', '<cmd>Pick files<cr>', {
  desc = 'Find files',
})
