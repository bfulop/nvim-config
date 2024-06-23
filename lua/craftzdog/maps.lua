local keymap = vim.keymap

keymap.set('n', 'x', '"_x')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
keymap.set('n', 'dw', 'vb"_d')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- New tab
-- keymap.set('n', 'te', ':tabedit')
-- Split window
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
-- Move window
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')

-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')

-- Unimpaired
keymap.set('n', '[<space>', require('custom.unimpaired').paste_blank_line_above)
keymap.set('n', ']<space>', require('custom.unimpaired').paste_blank_line_below)

-- Gonvim
keymap.set('n', '<C-g><C-5>', ':GonvimWorkspacePrevious<CR>')
keymap.set('n', '<C-g><C-]>', ':GonvimWorkspaceNext<CR>')
keymap.set('n', '<C-g><C-n>', ':GonvimWorkspaceNew<CR>')

-- Highlight word toggle
keymap.set("n", "<leader>m", ":HiMyWordsToggle<CR>", { noremap = true })
keymap.set("n", "<leader><C-m>", ":HiMyWordsClear<CR>", { noremap = true })

-- Neon tree
keymap.set('n', '<leader>no', ':NeoTreeShow<CR>')
keymap.set('n', '<leader>nw', ':NeoTreeClose<CR>')


-- Trouble

-- keymap.set('n', '<leader>a', '<Cmd>TroubleToggle<CR>', opts)
-- keymap.set('n', 'gl', '<Cmd>TroubleToggle document_diagnostics<CR>', opts)
-- keymap.set('n', 'gd', '<Cmd>TroubleToggle lsp_references<CR>', opts)
-- -- Go to definition
-- keymap.set("n", "gi", "<cmd>TroubleToggle lsp_definitions<CR>")
-- keymap.set("n", "gt", "<cmd>TroubleToggle lsp_type_definitions<CR>")

-- Trouble
keymap.set('n', '<leader>xr', '<cmd>Trouble diagnostics toggle<cr>', { desc = "Diagnostics (Trouble)" })
keymap.set('n', 'gl', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = "Buffer Diagnostics (Trouble)" })
keymap.set('n', '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = "Symbols (Trouble)" })
keymap.set('n', '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
  { desc = "LSP Definitions / references / ... (Trouble)" })
keymap.set('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>', { desc = "Location List (Trouble)" })
keymap.set('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', { desc = "Quickfix List (Trouble)" })

-- Go to definition
keymap.set("n", "gi", "<cmd>Trouble lsp_definitions<CR>")
keymap.set("n", "gt", "<cmd>Trouble lsp_type_definitions<CR>")

-- Additional keybindings
-- keymap.set('n', '<leader>a', '<cmd>TroubleToggle<CR>', { desc = "Toggle Trouble" })
-- keymap.set('n', 'gl', '<cmd>Trouble document_diagnostics<CR>', { desc = "Document Diagnostics (Trouble)" })
keymap.set('n', 'gd', '<cmd>Trouble lsp_references<CR>', { desc = "LSP References (Trouble)" })


local function get_git_root()
  local handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
  local git_root = handle:read("*a"):gsub("\n", "")
  handle:close()
  return git_root
end

_G.copy_buffer_diagnostics = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local diagnostics = vim.diagnostic.get(bufnr)
  local result = {}
  local file_path = vim.api.nvim_buf_get_name(bufnr)
  local git_root = get_git_root()

  if git_root and file_path:sub(1, #git_root) == git_root then
    file_path = file_path:sub(#git_root + 2)
  end

  for _, diag in ipairs(diagnostics) do
    local line = diag.lnum + 1 -- Convert 0-based to 1-based line number
    local col = diag.col + 1   -- Convert 0-based to 1-based column number
    local message = string.format("%s:%d:%d: %s", file_path, line, col, diag.message)
    table.insert(result, message)
  end

  local diagnostics_str = table.concat(result, "\n")
  vim.fn.setreg('+', diagnostics_str)
  print("Buffer diagnostics copied to clipboard")
end

vim.api.nvim_set_keymap('n', '<leader>cb', ':lua copy_buffer_diagnostics()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cb', ':lua copy_buffer_diagnostics()<CR>', { noremap = true, silent = true })
