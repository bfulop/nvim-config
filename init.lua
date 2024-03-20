vim.cmd([[
let $PATH=$PATH.':/Users/balint.fulop/.fnm/aliases/default/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/laps'
]])

vim.g.background = 'light'
vim.opt.backupcopy = 'yes'

require('craftzdog.base')
require('craftzdog.highlights')
require('craftzdog.maps')
require('craftzdog.plugins')

local has = function(x)
  return vim.fn.has(x) == 1
end
local is_mac = has "macunix"
local is_win = has "win32"
local is_wsl = has "wsl"

if is_mac then
  require('craftzdog.macos')
end
if is_win then
  require('craftzdog.windows')
end
if is_wsl then
  require('craftzdog.wsl')
end
