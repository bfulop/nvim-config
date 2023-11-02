local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

bufferline.setup({
  options = {
    mode = "tabs",
    separator_style = 'thin',
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true
  },
  highlights = {
    separator = {
      fg = '#CBD7DC',
      bg = '#EDEBE9',
    },
    separator_selected = {
      fg = '#EDEBE9',
      bg = '#EDEBE9',
    },
    background = {
      fg = '#56759A',
      bg = '#EDEBE9'
    },
    buffer_selected = {
      fg = '#56759A',
      bold = true,
    },
    fill = {
      bg = '#EDEBE9'
    }
  },
})

-- vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
-- vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
