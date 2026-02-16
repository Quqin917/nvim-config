return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- 'window' is now 'win'
      win = {
        border = "rounded", -- none, single, double, shadow
        -- position is handled differently in v3, usually defaults to bottom
      },
    },
    config = function(_, opts)
      local wk = require "which-key"
      wk.setup(opts)

      -- Register mappings using the new v3 spec
      wk.add {
        { "<leader>f", group = "Find" }, -- Group name
        { "<leader>b", group = "Buffers" },
        { "<leader>c", group = "Code" },
      }
    end,
  },
}
