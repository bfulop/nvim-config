vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 6
vim.opt.wildoptions = 'pum'
vim.opt.pumblend = 6
vim.opt.background = 'light'
-- vim.opt.background = 'dark'

vim.api.nvim_set_hl(0, "CmpItemKindCody", { fg = "Red" })
-- highlight yanked text for 200ms using the "Visual" highlight group
vim.cmd [[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
  augroup END
]]
