-- Put this at the top of 'init.lua'
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    -- Uncomment next line to use 'stable' branch
    -- '--branch', 'stable',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
end


require('mini.ai').setup({n_lines = 1000})
require('mini.surround').setup({n_lines = 1000})
require('mini.pick').setup()

-- Fuzzy file picker ----------------------------------------------------------
-- Uses mini.pick, which is already available through mini.nvim above.
-- <leader>ff works everywhere. <D-p> works in GUI Neovim clients that forward
-- the macOS Command key to Neovim; many terminal emulators reserve Cmd+P.
vim.keymap.set('n', '<leader>ff', '<cmd>Pick files<cr>', {
  desc = 'Find files',
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

-- Disable line numbers
vim.opt.number = true
vim.opt.relativenumber = false


vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.timeoutlen = 1000  -- Give <leader> mappings 1 second to complete

-- Use Neovim's default light theme, but override only the main editor backgrounds.
vim.o.background = 'light'

vim.api.nvim_set_hl(0, 'Normal', {
  bg = '#F7F7F7',
})

vim.api.nvim_set_hl(0, 'NormalNC', {
  bg = '#F7F7F7',
})

vim.o.spell = true        -- Enable spellchecking globally
vim.o.spelllang = 'en_us'


-- Disable syncing the dirty state
vim.cmd([[
  augroup DisableAutoSaveOnUndoRedo
    autocmd!
    autocmd BufEnter * autocmd! BufModifiedSet
  augroup END
]])


-- Put this in your init.lua
vim.keymap.set('n', 'v', 'v', { noremap = true }) -- Keep default 'v' behavior in normal mode

-- Only trigger expand selection when in visual mode
vim.keymap.set('x', 'v', function()
    require('vscode').action('editor.action.smartSelect.expand')
end)


-- TypeScript LSP -------------------------------------------------------------
-- Install the server outside Neovim, for example:
--   npm install -g typescript typescript-language-server
-- or add it to your project devDependencies.

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  root_markers = {
    'tsconfig.json',
    'jsconfig.json',
    'package.json',
    '.git',
  },
})

vim.lsp.enable({ 'ts_ls' })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
  end,
})

-- Put all current Neovim diagnostics into the quickfix list.
vim.keymap.set('n', '<leader>dq', function()
  vim.diagnostic.setqflist()
  vim.cmd('copen')
end, { desc = 'Diagnostics to quickfix' })

-- Put all current Neovim diagnostics into a normal yankable buffer.
vim.api.nvim_create_user_command('DiagnosticsBuffer', function()
  local diagnostics = vim.diagnostic.get(nil)

  table.sort(diagnostics, function(a, b)
    if a.bufnr ~= b.bufnr then
      return a.bufnr < b.bufnr
    end
    if a.lnum ~= b.lnum then
      return a.lnum < b.lnum
    end
    return a.col < b.col
  end)

  local severity_names = {
    [vim.diagnostic.severity.ERROR] = 'ERROR',
    [vim.diagnostic.severity.WARN] = 'WARN',
    [vim.diagnostic.severity.INFO] = 'INFO',
    [vim.diagnostic.severity.HINT] = 'HINT',
  }

  local lines = {}

  for _, diagnostic in ipairs(diagnostics) do
    local filename = vim.api.nvim_buf_get_name(diagnostic.bufnr)
    local severity = severity_names[diagnostic.severity] or 'UNKNOWN'
    local source = diagnostic.source or 'diagnostic'
    local line = diagnostic.lnum + 1
    local col = diagnostic.col + 1
    local message = diagnostic.message:gsub('\n', ' ')

    table.insert(lines, string.format(
      '%s:%d:%d: [%s] [%s] %s',
      filename,
      line,
      col,
      severity,
      source,
      message
    ))
  end

  if #lines == 0 then
    table.insert(lines, 'No diagnostics currently known to Neovim.')
  end

  vim.cmd('new')
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'wipe'
  vim.bo.swapfile = false
  vim.bo.filetype = 'diagnostics'
  vim.api.nvim_buf_set_name(0, 'Diagnostics')
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end, {})

vim.keymap.set('n', '<leader>dB', '<cmd>DiagnosticsBuffer<cr>', {
  desc = 'Diagnostics to yankable buffer',
})


-- diagnostics with error messages

vim.api.nvim_create_user_command('DiagnosticsBufferWithContext', function()
  local context_lines = 2
  local diagnostics = vim.diagnostic.get(nil)

  table.sort(diagnostics, function(a, b)
    if a.bufnr ~= b.bufnr then
      return a.bufnr < b.bufnr
    end
    if a.lnum ~= b.lnum then
      return a.lnum < b.lnum
    end
    return a.col < b.col
  end)

  local severity_names = {
    [vim.diagnostic.severity.ERROR] = 'ERROR',
    [vim.diagnostic.severity.WARN] = 'WARN',
    [vim.diagnostic.severity.INFO] = 'INFO',
    [vim.diagnostic.severity.HINT] = 'HINT',
  }

  local lines = {}

  for _, diagnostic in ipairs(diagnostics) do
    local bufnr = diagnostic.bufnr
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':.')
    local severity = severity_names[diagnostic.severity] or 'UNKNOWN'
    local source = diagnostic.source or 'diagnostic'
    local line = diagnostic.lnum + 1
    local col = diagnostic.col + 1
    local message = diagnostic.message:gsub('\n', ' ')

    table.insert(lines, string.format(
      '%s:%d:%d: [%s] [%s] %s',
      filename,
      line,
      col,
      severity,
      source,
      message
    ))

    local start_line = math.max(diagnostic.lnum - context_lines, 0)
    local end_line = math.min(
      diagnostic.lnum + context_lines + 1,
      vim.api.nvim_buf_line_count(bufnr)
    )

    local code_lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line, false)

    table.insert(lines, '')
    table.insert(lines, '```')

    for i, code_line in ipairs(code_lines) do
      local actual_lnum = start_line + i
      local marker = actual_lnum == line and '>' or ' '
      table.insert(lines, string.format(
        '%s %4d | %s',
        marker,
        actual_lnum,
        code_line
      ))
    end

    table.insert(lines, '```')
    table.insert(lines, '')
  end

  if #lines == 0 then
    table.insert(lines, 'No diagnostics currently known to Neovim.')
  end

  vim.cmd('new')
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'wipe'
  vim.bo.swapfile = false
  vim.bo.filetype = 'markdown'
  vim.api.nvim_buf_set_name(0, 'Diagnostics with context')
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end, {})

vim.keymap.set('n', '<leader>dC', '<cmd>DiagnosticsBufferWithContext<cr>', {
  desc = 'Diagnostics to yankable buffer with code context',
})

-- Yank visual selection with file path and line numbers -----------------------
-- Select text in visual mode, then press <leader>y.
-- The clipboard will contain a Markdown-friendly snippet, for example:
--   src/example.ts:10-14
--   ```typescript
--   <selected text>
--   ```
local function yank_selection_with_location()
  -- In a visual-mode mapping, '< and '> can still point at the previous visual
  -- selection. Use the live visual anchor ('v') and cursor ('.') instead.
  local visual_mode = vim.fn.mode()
  local start_pos = vim.fn.getpos('v')
  local end_pos = vim.fn.getpos('.')

  local start_line = start_pos[2]
  local start_col = start_pos[3]
  local end_line = end_pos[2]
  local end_col = end_pos[3]

  if start_line > end_line or (start_line == end_line and start_col > end_col) then
    start_line, end_line = end_line, start_line
    start_col, end_col = end_col, start_col
  end

  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  if #lines == 0 then
    return
  end

  -- Linewise visual mode should copy whole lines, not just the cursor columns.
  if visual_mode ~= 'V' then
    if #lines == 1 then
      lines[1] = string.sub(lines[1], start_col, end_col)
    else
      lines[1] = string.sub(lines[1], start_col)
      lines[#lines] = string.sub(lines[#lines], 1, end_col)
    end
  end

  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
  local location

  if start_line == end_line then
    location = string.format('%s:%d', filename, start_line)
  else
    location = string.format('%s:%d-%d', filename, start_line, end_line)
  end

  local filetype = vim.bo.filetype
  if filetype == '' then
    filetype = 'text'
  end

  local clipboard_lines = { location, '```' .. filetype }
  vim.list_extend(clipboard_lines, lines)
  table.insert(clipboard_lines, '```')

  vim.fn.setreg('+', table.concat(clipboard_lines, '\n'))
  vim.notify('Yanked selection with file path, line numbers, and Markdown code fence')
end

vim.keymap.set('x', '<leader>y', yank_selection_with_location, {
  desc = 'Yank selection with file path and line numbers',
})
