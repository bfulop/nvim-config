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

vim.keymap.set('n', '<leader>yp', function()
  local filename = vim.api.nvim_buf_get_name(0)

  if filename == '' then
    vim.notify('Current buffer has no file path', vim.log.levels.WARN)
    return
  end

  local relative_path = vim.fn.fnamemodify(filename, ':.')
  vim.fn.setreg('+', relative_path)
  vim.notify('Yanked file path: ' .. relative_path)
end, {
  desc = 'Yank current file path',
})
