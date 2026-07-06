return {
  -- [LSP] Native Setup (Strict v0.12+ compliant)
  {
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
  },

  -- [AUTOCOMPLETE]
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require "cmp"
      local luasnip = require "luasnip"
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup {
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert {
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm { select = true },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      }
    end,
  },

  -- [FORMATTING]
  {
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
  },
}
