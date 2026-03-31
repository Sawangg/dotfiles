vim.pack.add({
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
})

require("oil").setup({
  columns = { "icon" },
  keymaps = {
    ["<C-h>"] = false,
  },
  view_options = {
    show_hidden = true,
  },
})
