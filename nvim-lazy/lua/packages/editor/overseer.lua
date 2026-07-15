return {
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
}
