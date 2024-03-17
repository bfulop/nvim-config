local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.setup({
  ui = {
    title = false,
    border = 'solid',
    winblend = 12,
    kind = {
      Folder = { '' },
      File = { ' ', "@comment" },
      Module = { ' ', "@comment" },
      Namespace = { '蘿', "@comment" },
      Package = { ' ', "@comment" },
      Class = { ' ', "@comment" },
      Method = { '省', "@comment" },
      Property = { '  ', "@comment" },
      Field = { '', "@comment" },
      Constructor = { '', "@comment" },
      Enum = { '了', "@comment" },
      Interface = { '拓', "@comment" },
      Function = { '𝝺 ', "@comment" },
      Variable = { '珞 ', "@comment" },
      Constant = { '𢡊', "@comment" },
      String = { ' ', "@comment" },
      Number = { ' ', "@comment" },
      Boolean = { ' ', "@comment" },
      Array = { '  ', "@comment" },
      Object = { ' ', "@comment" },
      Key = { '  ', "@comment" },
      Null = { ' ', "@comment" },
      EnumMember = { '羅', "@comment" },
      Struct = { '藍', "@comment" },
      Event = { '鷺', "@comment" },
      Operator = { ' ', "@comment" },
      TypeParameter = { '  ', "@comment" },
      -- ccls
      TypeAlias = { '識', "@comment" },
      Parameter = { ' ', "@comment" },
      StaticMethod = { 'ﴂ ', "@comment" },
      Macro = { ' ', "@comment" },
      -- for completion sb microsoft!!!
      Text = { '', "@comment" },
      Snippet = { ' ', "@comment" },
      Unit = { '祿', "@comment" },
      Value = { ' ', "@comment" },
      -- extra stuff I've found
      --FolderName = { '  ', colors.blue },
      -- Word = { '  ', colors.blue },
    }
  },
  symbol_in_winbar = {
    enable = false,
    separator = ' ⟩ ',
    hide_keyword = true,
    show_file = true,
    folder_level = 4,
    respect_root = false,
    color_mode = false,
    delay = 600,
  },
  outline = {
    win_position = 'right',
    win_with = '',
    win_width = 30,
    show_detail = true,
    auto_preview = true,
    auto_refresh = true,
    auto_close = true,
    custom_sort = nil,
    keys = {
      jump = 'o',
      expand_collapse = 'u',
      quit = 'q',
    },
  },
  lightbulb = {
    enable = false,
    enable_in_insert = false,
    sign = false,
    sign_priority = 40,
    virtual_text = false,
  },
  diagnostic = {
    on_insert = false,
    on_insert_follow = false,
  },
})

-- saga.init_lsp_saga {
--   server_filetype_map = {
--     typescript = 'typescript'
--   }
-- }

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', '<C-h>', '<Cmd>Lspsaga show_line_diagnostics<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
-- vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
vim.keymap.set('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', '<leader>w', '<Cmd>Lspsaga winbar_toggle<CR>', opts)

-- code action
local codeaction = require("lspsaga.codeaction")
vim.keymap.set("n", "<leader>ca", function() codeaction:code_action() end, { silent = true })
vim.keymap.set("v", "<leader>ca", function()
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
  codeaction:range_code_action()
end, { silent = true })
