-- Keep default 'v' behavior in normal mode.
vim.keymap.set('n', 'v', 'v', { noremap = true })

-- In VSCode Neovim, use VSCode's semantic expand-selection action.
-- In regular Neovim, leave visual-mode 'v' completely untouched.
local has_vscode, vscode = pcall(require, 'vscode')

if has_vscode then
  vim.keymap.set('x', 'v', function()
    vscode.action('editor.action.smartSelect.expand')
  end)
end
