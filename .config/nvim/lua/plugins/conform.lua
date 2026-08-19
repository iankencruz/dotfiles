return {
  {
    "stevearc/conform.nvim",
    opts = {
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters = {
        sleek = {
          command = "sleek",
          args = { "-U", "true", "-l", "2", "-i", "2" },
          stdin = true,
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        json = { "jq" },
        sql = { "sleek" },
        pgsql = { "sleek" },
        rust = { "rustfmt" },
        python = { "black" },
        htmldjango = { "djlint" },
        html = { "oxfmt" },
        javascript = { "oxfmt", "prettierd" },
        typescript = { "oxfmt", "prettierd" },
        go = { "goimports", "gofumpt" },
        svelte = { "oxfmt", "prettierd", "prettier" },
      },
    },
  },
}
