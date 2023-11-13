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
keymap.set("n", "<leader>m", ":HiMyWordsToggle<CR>", { noremap = true })
keymap.set("n", "<leader><C-m>", ":HiMyWordsClear<CR>", { noremap = true })

-- Neon tree
keymap.set('n', '<leader>no', ':NeoTreeShow<CR>')
keymap.set('n', '<leader>nw', ':NeoTreeClose<CR>')


-- Trouble

keymap.set('n', '<leader>a', '<Cmd>TroubleToggle<CR>', opts)
keymap.set('n', 'gl', '<Cmd>TroubleToggle document_diagnostics<CR>', opts)
keymap.set('n', 'gd', '<Cmd>TroubleToggle lsp_references<CR>', opts)
-- Go to definition
keymap.set("n", "gi", "<cmd>TroubleToggle lsp_definitions<CR>")
keymap.set("n", "gt", "<cmd>TroubleToggle lsp_type_definitions<CR>")


-- gitlab review
local gitlab = require("gitlab")
vim.keymap.set("n", "<leader>glr", gitlab.review)
vim.keymap.set("n", "<leader>gls", gitlab.summary)
vim.keymap.set("n", "<leader>glA", gitlab.approve)
vim.keymap.set("n", "<leader>glR", gitlab.revoke)
vim.keymap.set("n", "<leader>glc", gitlab.create_comment)
vim.keymap.set("v", "<leader>glc", gitlab.create_multiline_comment)
vim.keymap.set("v", "<leader>glC", gitlab.create_comment_suggestion)
vim.keymap.set("n", "<leader>gln", gitlab.create_note)
vim.keymap.set("n", "<leader>gld", gitlab.toggle_discussions)
vim.keymap.set("n", "<leader>glaa", gitlab.add_assignee)
vim.keymap.set("n", "<leader>glad", gitlab.delete_assignee)
vim.keymap.set("n", "<leader>glra", gitlab.add_reviewer)
vim.keymap.set("n", "<leader>glrd", gitlab.delete_reviewer)
vim.keymap.set("n", "<leader>glp", gitlab.pipeline)
vim.keymap.set("n", "<leader>glo", gitlab.open_in_browser)
