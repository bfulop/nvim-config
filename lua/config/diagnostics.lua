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
