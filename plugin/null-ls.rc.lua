local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

-- register any number of sources simultaneously
local sources = {
  -- require("typescript.extensions.null-ls.code-actions"),
  null_ls.builtins.formatting.prettierd.with({
    diagnostic_config = {
      virtual_text = false,
    }
  }),
  null_ls.builtins.completion.spell,
  null_ls.builtins.diagnostics.eslint_d.with({
    diagnostics_format = '[eslint] #{m}\n(#{c})',
    diagnostic_config = {
      virtual_text = false,
    }
  }),
}

null_ls.setup { sources = {
  sources = vim.tbl_map(function(source)
    return source.with({
      diagnostics_postprocess = function(diagnostic)
        if diagnostic.severity == vim.diagnostic.severity.ERROR then
          diagnostic.severity = vim.diagnostic.severity.HINT
        end
      end,
    })
  end, sources),
},
  update_in_insert = false,

  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          lsp_formatting(bufnr)
        end,
      })
    end
  end
}

vim.api.nvim_create_user_command(
  'DisableLspFormatting',
  function()
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
  end,
  { nargs = 0 }
)
