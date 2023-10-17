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
keymap.set('n', 'te', ':tabedit')
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
vim.api.nvim_set_keymap("n", "<leader>m", ":HiMyWordsToggle<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-m>", ":HiMyWordsClear<CR>", { noremap = true })

-- Neon tree
vim.keymap.set('n', '<leader>no', ':NeoTreeShow<CR>')
vim.keymap.set('n', '<leader>nw', ':NeoTreeClose<CR>')


-- Trouble

vim.keymap.set('n', '<leader>a', '<Cmd>TroubleToggle<CR>', opts)
vim.keymap.set('n', 'gl', '<Cmd>TroubleToggle document_diagnostics<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>TroubleToggle lsp_references<CR>', opts)
-- Go to definition
vim.keymap.set("n", "gi", "<cmd>TroubleToggle lsp_definitions<CR>")
vim.keymap.set("n", "gt", "<cmd>TroubleToggle lsp_type_definitions<CR>")
