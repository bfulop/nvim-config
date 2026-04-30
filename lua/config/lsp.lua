-- TypeScript + ESLint LSP ----------------------------------------------------
-- Install the servers outside Neovim, for example:
--   npm install -g @typescript/native-preview vscode-langservers-extracted
-- or add them to your project devDependencies:
--   npm install -D @typescript/native-preview vscode-langservers-extracted
--
-- To go back to the classic TypeScript language server, change this to 'ts_ls'
-- and install: npm install -g typescript typescript-language-server
local typescript_lsp = 'tsgo'

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

local js_ts_filetypes = {
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact',
}

local tsgo_root_markers = {
  'package-lock.json',
  'yarn.lock',
  'pnpm-lock.yaml',
  'bun.lockb',
  'bun.lock',
  'package.json',
  'tsconfig.json',
  'jsconfig.json',
  '.git',
}

vim.lsp.config('tsgo', {
  -- Prefer the project-local tsgo from node_modules, falling back to PATH.
  cmd = function(dispatchers, config)
    local cmd = 'tsgo'

    if config and config.root_dir then
      local local_cmd = vim.fs.joinpath(config.root_dir, 'node_modules', '.bin', 'tsgo')
      if vim.fn.executable(local_cmd) == 1 then
        cmd = local_cmd
      end
    end

    return vim.lsp.rpc.start({ cmd, '--lsp', '--stdio' }, dispatchers)
  end,
  filetypes = js_ts_filetypes,
  root_markers = tsgo_root_markers,
})

vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = js_ts_filetypes,
  root_markers = {
    'tsconfig.json',
    'jsconfig.json',
    'package.json',
    '.git',
  },
})

vim.lsp.config('eslint', {
  cmd = { 'vscode-eslint-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
    'svelte',
    'astro',
  },
  root_markers = {
    'eslint.config.js',
    'eslint.config.mjs',
    'eslint.config.cjs',
    'eslint.config.ts',
    '.eslintrc',
    '.eslintrc.js',
    '.eslintrc.cjs',
    '.eslintrc.yaml',
    '.eslintrc.yml',
    '.eslintrc.json',
    'package.json',
    '.git',
  },
})

vim.lsp.enable({ typescript_lsp, 'eslint' })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
  end,
})

-- Optional ESLint fix-all on save. Disabled by default to keep edits explicit.
-- Uncomment if you want ESLint fixes to run before saving JS/TS files.
-- vim.api.nvim_create_autocmd('BufWritePre', {
--   pattern = { '*.js', '*.jsx', '*.ts', '*.tsx' },
--   callback = function()
--     vim.lsp.buf.code_action({
--       context = {
--         only = { 'source.fixAll.eslint' },
--         diagnostics = {},
--       },
--       apply = true,
--     })
--   end,
-- })
