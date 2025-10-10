return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      integrations = {
        mason = true,
      },
    },
    init = function()
      vim.cmd.colorscheme("catppuccin-mocha") -- Default colorscheme
      vim.cmd.hi("Comment gui=none") -- Disable the default gui on launch
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    end,
  },
}
