local status, aerial = pcall(require, 'aerial')
if (not status) then return end

aerial.setup({
  backends = { "treesitter", "lsp"  },
  filter_kind = false,
})
