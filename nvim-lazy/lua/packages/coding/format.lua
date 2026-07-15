return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      c = { "clang-format" },
      cpp = { "clang-format" },
    },
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
  },

  vim.keymap.set(
    "n",
    "<leader>fm",
    function() require("conform").format { lsp_fallback = true } end,
    { desc = "Format File" }
  ),
}
