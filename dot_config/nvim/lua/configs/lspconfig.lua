-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

-- require("lspconfig.configs").vtsls = require("vtsls").lspconfig

local lspconfig = require "lspconfig"

local nvlsp = require "nvchad.configs.lspconfig"

local ok, util = pcall(require, "lspconfig.util")
if not ok then
  vim.notify "lspconfig.util could not be loaded"
  return
end
--
--  --configuring single server, example: typescript
-- lspconfig.ts_ls.setup {}
--

require("typescript-tools").setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  root_dir = util.root_pattern(
    -- '.eslintrc.js',
    -- '.eslintrc.cjs',
    -- '.eslintrc.yaml',
    -- '.eslintrc.yml',
    -- '.eslintrc.json',
    "package.json",
    "tsconfig.json",
    "yarn.lock",
    "pnpm-lock.yaml",
    ".git"
  ),
  single_file_support = false,
}

lspconfig["denols"].setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  root_dir = util.root_pattern("deno.lock", "deno.jsonc"),
  single_file_support = false,
}

lspconfig["tailwindcss"].setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  root_dir = util.root_pattern(
    "tailwind.config.js",
    "tailwind.config.mjs",
    "tailwind.config.cjs",
    "tailwind.config.ts"
  ),
  single_file_support = false,
}
-- EXAMPLE
local servers = {
  "html",
  "cssls",
  "pyright",
  "prismals",
  "jqls",
  "jsonls",
  "graphql",
  "rust_analyzer",
  "docker_compose_language_service",
  "dockerls",
  "ast_grep",
  "postgres_lsp",
  -- "postgrestools",
  -- "glint",
}
-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.eslint.setup {
  --- ...
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- lspconfig["vtsls"].setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
--   root_dir = util.root_pattern(
--     -- '.eslintrc.js',
--     -- '.eslintrc.cjs',
--     -- '.eslintrc.yaml',
--     -- '.eslintrc.yml',
--     -- '.eslintrc.json',
--     "package.json",
--     "tsconfig.json",
--     "yarn.lock",
--     "pnpm-lock.yaml",
--     ".git"
--   ),
--   single_file_support = false,
-- }
