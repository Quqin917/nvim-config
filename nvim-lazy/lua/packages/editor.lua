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

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function() require("telescope").load_extension "fzf" end,
      },
    },

    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep (Search Text)" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
    },

    config = function()
      local telescope = require "telescope"

      telescope.setup {
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            vertical = { mirror = false },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          sorting_strategy = "ascending",
          winblend = 0,
          mappings = {
            i = {
              ["<C-k>"] = "move_selection_previous",
              ["<C-j>"] = "move_selection_next",
              ["<C-q>"] = "send_to_qflist",
              -- Note: <C-d> to delete a buffer is already mapped natively in Telescope!
            },
          },
        },
      }
    end,
  },

  -- Auto close brackets/quotes
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- Easy commenting with 'gcc'
  {
    "numToStr/Comment.nvim",
    config = function() require("Comment").setup() end,
  },

  -- Change quotes/brackets easily
  -- Usage: `ysiw"` to surround word with ", `ds"` to delete "
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function() require("nvim-surround").setup {} end,
  },

  {
    "stevearc/overseer.nvim",
    config = function()
      local overseer = require "overseer"

      overseer.setup {
        dap = false,
        strategy = "terminal",
        templates = { "builtin" },
        form = { border = "rounded" },
        task_list = {
          direction = "bottom",
          min_height = 10,
          max_height = 15,
        },
      }

      -- Bear + Makefile (For C/C++ projects)
      overseer.register_template {
        name = "Build with Bear (Make)",

        builder = function()
          local makefile_match = vim.fs.find("Makefile", { upward = true, path = vim.fn.expand "%:p:h" })
          local target_dir = #makefile_match > 0 and vim.fs.dirname(makefile_match[1]) or vim.fn.getcwd()

          return {
            cmd = { "bear" },
            args = { "--", "make" },
            cwd = target_dir,
            components = { { "on_output_quickfix", open = true }, "default" },
          }
        end,
        condition = {
          filetype = { "c", "cpp" },
          callback = function() return vim.fn.filereadable(vim.fn.getcwd() .. "/Makefile") == 1 end,
        },
      }

      -- Global Keybindings for Task Management
      vim.keymap.set("n", "<leader>or", "<cmd>OverseerRun<CR>", { desc = "Run Task" })
      vim.keymap.set("n", "<leader>ot", "<cmd>OverseerToggle<CR>", { desc = "Toggle Overseer UI" })
      vim.keymap.set("n", "<leader>oi", "<cmd>OverseerInfo<CR>", { desc = "Overseer Info" })
    end,
  },
}
