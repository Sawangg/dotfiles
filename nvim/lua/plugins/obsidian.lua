return {
  { -- Note taking plugin using obsidian
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    -- Loads the plugin when opening notes in ~/Documents/Notes/
    event = {
      "BufReadPre " .. vim.fn.expand "~" .. "/Documents/Notes/*.md",
      "BufNewFile " .. vim.fn.expand "~" .. "/Documents/Notes/*.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "vaults",
          path = "~/Documents/vaults/",
        }
      }
    }
  }
}
