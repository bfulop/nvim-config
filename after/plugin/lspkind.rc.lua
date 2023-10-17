local status, lspkind = pcall(require, "lspkind")
if (not status) then return end

lspkind.init({
  -- enables text annotations
  --
  -- default: true
  mode = 'symbol',

  -- default symbol map
  -- can be either 'default' (requires nerd-fonts font) or
  -- 'codicons' for codicon preset (requires vscode-codicons font)
  --
  -- default: 'default'
  preset = 'codicons',

  -- override preset symbols
  --
  -- default: {}
  -- symbol_map = {
  --   Text = "𝛜",
  --   Method = "▷",
  --   Function = "ƛ",
  --   Constructor = "⊛",
  --   Field = "◆",
  --   Variable = "⋕",
  --   Class = "☐",
  --   Interface = "⋇",
  --   Module = "⨹",
  --   Property = "✤",
  --   Unit = "𐄹",
  --   Value = "🞭",
  --   Enum = "≡",
  --   Keyword = "≂",
  --   Snippet = "",
  --   Color = "✾",
  --   File = "⌮",
  --   Reference = "",
  --   Folder = ">",
  --   EnumMember = "",
  --   Constant = "ℇ",
  --   Struct = "פּ",
  --   Event = "",
  --   Operator = "○",
  --   TypeParameter = "≶"
  -- },
})
