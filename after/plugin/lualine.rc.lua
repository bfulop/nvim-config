local status, lualine = pcall(require, "lualine")
if (not status) then return end

lualine.setup {
  options = {
    icons_enabled = true,
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {
      {
        'mode',
        color = { bg = 'NONE', fg = "#bdbbb6" },
        separator = { right = nil, left = nil }
      }
    },
    lualine_b = {},
    lualine_c = { {
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 1,           -- 0 = just filename, 1 = relative path, 2 = absolute path
      shorting_target = 60,
      use_mode_colors = true
    } },
    lualine_x = {
      {
        'diagnostics',
        sources = { "nvim_diagnostic" },
        symbols = {
          error = ' ',
          warn = ' ',
          info = ' ',
          hint = ' '
        }
      },
      'encoding',
      'filetype'
    },
    lualine_y = {
      {
        'progress',
        color = { bg = 'NONE', fg = "#56759A" },
        separator = { right = nil, left = '' }
      }
    },
    lualine_z = {
      {
        'location',
        color = { bg = 'NONE', fg = "#bdbbb6" },
        separator = { right = nil, left = '' }
      }
    }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { {
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 1            -- 0 = just filename, 1 = relative path, 2 = absolute path
    } },
    lualine_x = { {
      'location',
      color = { bg = 'NONE' }
    } },
    lualine_y = {},
    lualine_z = { { color = { bg = 'NONE' } } }
  },
  tabline = {},
  extensions = { 'fugitive' }
}
