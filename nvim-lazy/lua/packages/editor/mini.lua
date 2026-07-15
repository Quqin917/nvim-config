return {
  {
    "echasnovski/mini.files",
    keys = {
      {
        "<leader>e",
        function() require("mini.files").open(vim.api.nvim_buf_get_name(0), true) end,
        desc = "Open Current File",
      },
    },

    config = function()
      require("mini.files").setup {
        windows = {
          preview = true,
          width_focus = 30,
          width_nofocus = 15,
          width_preview = 40,
        },
        options = {
          use_as_default_explorer = true,
        },
        mappings = {
          close = "q",
          go_in = "l",
          go_in_plus = "L",
          go_out = "h",
          go_out_plus = "H",
          reset = "<BS>",
          reveal_cwd = "@",
          show_help = "g?",
          synchronize = "=",
          trim_left = "<",
          trim_right = ">",
        },
      }
    end,
  },

  {
    "echasnovski/mini.bufremove",
    version = "*",
    keys = {
      {
        "<leader>d",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = "Close current buffer",
      },
    },
  },
}
