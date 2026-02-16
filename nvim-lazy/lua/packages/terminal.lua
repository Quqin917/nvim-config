return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup {
        size = 20,
        open_mapping = [[<c-\>]],
        direction = "float",
      }

      -- LazyGit Integration
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new { cmd = "lazygit", hidden = true }

      function _lazygit_toggle() lazygit:toggle() end
    end,
  },
}
