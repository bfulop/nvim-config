local status, trouble = pcall(require, "trouble")
if (not status) then return end

trouble.setup(
-- settings without a patched font or icons
  {
    height = 12,
    icons = true,
    fold_open = "v",     -- icon used for open folds
    fold_closed = ">",   -- icon used for closed folds
    indent_lines = true, -- add an indent guide below the fold icons
    mode = "document_diagnostics",
    signs = {
      -- icons / text used for a diagnostic
      error = "error",
      warning = "warn",
      hint = "hint",
      information = "info"
    },
    use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
  }
)
