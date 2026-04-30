-- Line numbers ----------------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = false

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.timeoutlen = 1000 -- Give <leader> mappings 1 second to complete

-- Use Neovim's default light theme, but override only the main editor backgrounds.
vim.o.background = 'light'

vim.api.nvim_set_hl(0, 'Normal', {
  bg = '#F7F7F7',
})

vim.api.nvim_set_hl(0, 'NormalNC', {
  bg = '#F7F7F7',
})

vim.o.spell = true -- Enable spellchecking globally
vim.o.spelllang = 'en_us'

-- Disable syncing the dirty state in VSCode Neovim only, where dirty-state
-- syncing can otherwise conflict with undo/redo behavior.
if pcall(require, 'vscode') then
  vim.cmd([[
    augroup DisableAutoSaveOnUndoRedo
      autocmd!
      autocmd BufEnter * autocmd! BufModifiedSet
    augroup END
  ]])
end
