return {
  { -- Linting support
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "<leader>l",
        function()
          require("lint").try_lint()
        end,
        desc = "[L]int buffer",
      },
    },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        yaml = { "yamllint" },
      }

      -- Create autocmd to trigger linting on more events
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim_lint", { clear = true }),
        callback = function()
          if vim.bo.modifiable then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
