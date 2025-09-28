return {
  {
    "ibhagwan/fzf-lua",
    event = "VimEnter",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    config = function()
      local fzf = require("fzf-lua")

      fzf.setup({
        hls = {
          normal = "Normal",
          border = "Normal",
          preview_normal = "Normal",
          preview_border = "Normal",
        },
      })
    end,
  },
}
