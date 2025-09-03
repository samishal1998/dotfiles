local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "eslint_d", "prettier", "biome" },
    typescript = { "eslint_d", "prettier", "biome" },
    json = { "prettier", "jq" },
    sql = { "sql-formatter", "sqlfmt", "sqlfluff" },
  },

  format_after_save = {
    -- These options will be passed to conform.format()
    timeout_ms =  30000,
    lsp_fallback = true,
    async = true,
  },
}

return options
