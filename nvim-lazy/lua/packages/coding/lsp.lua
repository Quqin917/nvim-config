return {
  "neovim/nvim-lspconfig",
  dependencies = { "hrsh7th/cmp-nvim-lsp" },

  config = function()
    -- 1. Setup Lua Language Server
    vim.lsp.config("lua_ls", {
      cmd = { "lua-language-server" },
      root_markers = { ".git", ".luarc.json", "init.lua" },
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    })
    vim.lsp.enable "lua_ls"

    -- 2. Setup Clangd (C/C++)
    vim.lsp.config("clangd", {
      cmd = { "clangd", "--background-index", "--clang-tidy" },
      root_markers = { ".git", "compile_commands.json" },
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })
    vim.lsp.enable "clangd"

    -- 3. Setup Assembly (asm-lsp)
    vim.lsp.config("asm_lsp", {
      cmd = { "asm-lsp" },
      root_markers = { ".git" },
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })
    vim.lsp.enable "asm_lsp"

    -- 4. Setup Arduino (Requires arduino-cli and arduino-language-server)
    vim.lsp.config("arduino_language_server", {
      cmd = {
        "arduino-language-server",
        "-cli-config",
        vim.fn.expand "~/.arduino15/arduino-cli.yaml",
        "-cli",
        "/usr/bin/arduino-cli",
        "-clangd",
        "/usr/bin/clangd",
      },
      root_markers = { "sketch.yaml", "arduino.json", ".git" },
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })
    vim.lsp.enable "arduino_language_server"

    -- 5. Global Keybindings (LspAttach)
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local opts = { buffer = args.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
      end,
    })

    -- 6. Force filetype detection
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = { "*.asm", "*.s", "*.S" },
      command = "set filetype=asm",
    })

    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = { "*.ino", "*.pde" },
      command = "set filetype=arduino",
    })
  end,
}
