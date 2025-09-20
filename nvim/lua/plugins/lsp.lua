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
        harper_ls = {
          settings = {
            ["harper-ls"] = {
              linters = {
                SentenceCapitalization = false,
                SpellCheck = false,
                ToDoHyphen = false,
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      for name, user_cfg in pairs(opts.servers) do
        local final_cfg = vim.tbl_deep_extend("force", { capabilities = capabilities }, user_cfg)
        vim.lsp.config(name, final_cfg)
      end

      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(opts.servers or {}),
        automatic_installation = true,
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
        virtual_text = { source = "if_many", spacing = 2 },
      })
    end,
  },
}
