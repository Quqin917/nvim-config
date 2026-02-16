return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Required for icons
    config = function()
      require("oil").setup {
        -- Use oil as the default file explorer (replaces netrw)
        default_file_explorer = true,

        -- columns to display
        columns = {
          "icon",
          -- "permissions",
          -- "size",
          -- "mtime",
        },

        -- Window customization
        win_options = {
          wrap = false,
          signcolumn = "no",
          cursorcolumn = false,
          foldcolumn = "0",
          spell = false,
          list = false,
          conceallevel = 3,
          concealcursor = "nvic",
        },

        -- View options
        view_options = {
          show_hidden = true,
          is_always_hidden = function(name, bufnr) return name == ".." or name == ".git" end,
        },

        -- Floating window styling (optional, if you use float)
        float = {
          padding = 2,
          max_width = 90,
          max_height = 0,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
        },
      }

      -- Keymaps
      vim.keymap.set("n", "`", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require("nvim-tree").setup()
    end,
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

    config = function()
      local telescope = require "telescope"
      local builtin = require "telescope.builtin"

      telescope.setup {
        defaults = {
          -- Improving the layout for coding
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
              ["<C-k>"] = "move_selection_previous", -- Move up
              ["<C-j>"] = "move_selection_next", -- Move down
              ["<C-q>"] = "send_to_qflist", -- Send to quickfix list
            },
          },
        },
      }
    end,
  },

  -- [CODING] Autopairs (Auto close brackets/quotes)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- [CODING] Comment.nvim (Easy commenting with 'gcc')
  {
    "numToStr/Comment.nvim",
    config = function() require("Comment").setup() end,
  },

  -- [CODING] Surround (Change quotes/brackets easily)
  -- Usage: `ysiw"` to surround word with ", `ds"` to delete "
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function() require("nvim-surround").setup {} end,
  },
}
