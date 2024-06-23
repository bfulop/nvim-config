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

if not vim.g.vscode then
  require('mini.animate').setup({
    cursor = {
      enable = false,
    }
  })
end
