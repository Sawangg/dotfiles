return {
  { -- Autoformat your document
    "stevearc/conform.nvim",
    lazy = false,
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { { "biome", "prettierd" } },
        typescript = { { "biome", "prettierd" } },
      },
    },
  },
  { -- Set buffer options automatically
    "tpope/vim-sleuth"
  },
}
