return {
  { -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    "folke/tokyonight.nvim",
    priority = 1000,
    init = function()
      vim.cmd.colorscheme("tokyonight-night") -- Default colorscheme
      vim.cmd.hi("Comment gui=none") -- Disable the default gui on launch
    end,
  },
  { -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
  { "xiyaowong/transparent.nvim",
    opts= {
      vim.keymap.set("n", "<leader>t", "", { desc = "Toggle [T]ransparency" })
    }
  },
}
