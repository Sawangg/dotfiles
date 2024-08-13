return {
  { -- Manage your file system in a buffer
    "stevearc/oil.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font }
    },
    config = function ()
      require("oil").setup({
        columns = { "icon" },
        keymaps = {
          ["<C-h>"] = false,
        },
        view_options = {
          show_hidden = true,
        }
      })
    end
  }
}
