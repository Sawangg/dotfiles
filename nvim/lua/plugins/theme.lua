return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      integrations = {
        blink_cmp = true,
        fidget = true,
        mason = true,
        which_key = true,
      },
    },
    init = function()
      vim.cmd.colorscheme("catppuccin") -- Default colorscheme
      vim.cmd.hi("Comment gui=none") -- Disable the default gui on launch
    end,
  },
  { -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
}
