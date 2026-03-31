vim.pack.add({ "https://github.com/catppuccin/nvim" })

require("catppuccin").setup({
  transparent_background = true,
  integrations = {
    mason = true,
  },
})

vim.cmd.colorscheme("catppuccin-mocha")
vim.cmd.hi("Comment gui=none")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

require("statusline")
