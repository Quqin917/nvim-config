return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.config").setup {
        ensure_installed = { "lua", "c", "cpp", "vim", "vimdoc", "markdown", "asm" },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },

        -- Smart Selection (Text Objects)
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- Function selection
              ["af"] = "@function.outer", -- Select around function
              ["if"] = "@function.inner", -- Select inside function

              -- Class selection
              ["ac"] = "@class.outer", -- Select around class
              ["ic"] = "@class.inner", -- Select inside class

              -- Loop selection
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
            },
          },
        },
      }
    end,
  },
}
