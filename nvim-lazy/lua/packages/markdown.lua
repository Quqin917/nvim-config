return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    config = function()
      require("render-markdown").setup {
        heading = { sign = false, icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " } },
      }

      vim.keymap.set("n", "<leader>mp", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle Markdown Preview" })
    end,
  },
}
