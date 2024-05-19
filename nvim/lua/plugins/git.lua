return {
  { -- Git integration
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function ()
      require("neogit").setup({})
      vim.keymap.set("n", "<leader>ng", "<CMD>Neogit<CR>", { desc = "Open [N]eo[g]it"})
    end,
  },
  { -- Add signs in the gutter
    "lewis6991/gitsigns.nvim",
    config = function ()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })
      vim.keymap.set("n", "<leader>gp", "<CMD>Gitsigns preview_hunk_inline<CR>")
      vim.keymap.set("n", "<leader>gb", "<CMD>Gitsigns toggle_current_line_blame<CR>")
    end
  },
}
