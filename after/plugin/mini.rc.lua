_G.cursorword_blocklist = function()
  local curword = vim.fn.expand('<cword>')

  -- Add any disabling global or filetype-specific logic here
  local blocklist = { 'import', 'const', 'function', 'let', 'var',
    'local', 'interface', 'type', 'enum',
    'Partial', 'Omit', 'typeof', 'string', 'try', 'catch', 'finally', 'return',
    'if', 'else', 'for', 'while', 'break', 'continue', 'switch', 'case', 'default',
    'then', 'elseif', 'else', 'in', 'forin', 'with', 'new', 'try', 'catch', 'throw',
    'export', 'import', 'yield', 'default', 'await', 'async', 'public', 'private', 'class', 'readonly',
    'require', 'use', 'default', 'class', 'from'
  }
  vim.b.minicursorword_disable = vim.tbl_contains(blocklist, curword)
end

vim.cmd('au CursorMoved * lua _G.cursorword_blocklist()')

-- local ok, cursorword = pcall(require, "mini.cursorword")
-- if not ok then
--   return
-- end
-- cursorword.setup({
--   -- Delay (in ms) between when cursor moved and when highlighting appeared
--   delay = 1500,
-- })
--

require('mini.ai').setup({
  n_lines = 800,
  search_method = 'cover',
})
require('mini.surround').setup({
  mappings = {
    find = 'rf',
    find_left = 'rF',
    highlight = 'rs'
  },
  n_lines = 300
})
require('mini.animate').setup({
  cursor = {
    enable = false,
  }
})
