local status, project = pcall(require, "project_nvim")
if (not status) then return end

project.setup({
  manual_mode = true,
  sync_root_with_cwd = false,
  respect_buf_cwd = false,
  detection_methods = { "pattern", "lsp" },
  patterns = { ">modules", ">src", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
  silent_chdir = false,
  update_focused_file = {
    enable = false,
    update_root = false
  }
})

require('telescope').load_extension('projects')
