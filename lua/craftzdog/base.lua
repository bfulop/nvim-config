vim.cmd("autocmd!")

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.wo.number = true

vim.opt.linespace = 2
vim.opt.updatetime = 400
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 1
vim.opt.shell = 'zsh'
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false         -- No Wrap lines
vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
vim.opt.wildignore:append { '*/node_modules/*' }
vim.opt.termguicolors = true

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 9
vim.o.grepprg = "rg --vimgrep --smart-case --follow"

-- spell Checking
vim.opt.spelllang = 'en_us'
vim.opt.spell = false


-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = '*',
  command = "set nopaste"
})

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }

-- Balint settings
vim.g.background = 'light'
vim.opt.signcolumn = 'yes'

-- Neovide
if vim.fn.exists("g:neovide") then
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
end
vim.g.background = 'light'



local group = vim.api.nvim_create_augroup('SetVirtualEditNone', { clear = true })

-- For consistent cursor movements
vim.api.nvim_create_autocmd('BufEnter', {
  group = group,
  callback = function()
    vim.opt.virtualedit = 'none'
  end,
})
