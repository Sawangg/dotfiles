return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      integrations = {
        mason = true,
        diffview = true,
      },
    },
    init = function()
      vim.cmd.colorscheme("catppuccin-mocha") -- Default colorscheme
      vim.cmd.hi("Comment gui=none")          -- Disable the default gui on launch
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    end,
  },
  {
    "echasnovski/mini.nvim",
    config = function()
      local statusline = require("mini.statusline")
      -- set use_icons to true if you have a Nerd Font
      statusline.setup({ use_icons = vim.g.have_nerd_font })

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      statusline.section_location = function()
        return "%2l:%-2v"
      end
    end,
  },
}
