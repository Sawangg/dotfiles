return {
  { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",

      -- Installer of LSP tools to stdpath
      { "mason-org/mason.nvim", opts = {} },
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      servers = {
        lua_ls = {},
        harper_ls = {},
      },
    },
    config = function(_, opts)
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- TODO: Fix this because settings are not applied when using mason-lspconfig
      vim.lsp.config("harper_ls", {
        settings = {
          ["harper-ls"] = {
            linters = {
              SentenceCapitalization = false,
              SpellCheck = false,
              ToDoHyphen = false,
            },
          },
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(opts.servers or {}),
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server = opts.servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })

      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
          },
        } or {},
        virtual_text = {
          source = "if_many",
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      })
    end,
  },
}
