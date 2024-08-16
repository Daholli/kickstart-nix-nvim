-- Exit if the language server isn't available
if vim.fn.executable('rust-analyzer') ~= 1 then
  return
end

local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
  "n",
  "<leader>a",
  function()
    vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
  end,
  { silent = true, buffer = bufnr }
)

local root_files = {
  'flake.nix',
  'default.nix',
  'shell.nix',
  '.git',
  'Cargo.toml'
}

vim.lsp.start {
  name = 'rust-analyzer',
  cmd = { 'rust-analyzer' },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
}
