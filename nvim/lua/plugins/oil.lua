return {
  { -- Manage your file system in a buffer
    "stevearc/oil.nvim",
    opts = {
      view_options = {
        show_hidden = true,
      }
    },
    dependencies = {
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font }
    },
  }
}
