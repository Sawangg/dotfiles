-- Sawangs' nvim config
vim.loader.enable()

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Nerd fonts support
vim.g.have_nerd_font = true

-- Disable external providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- vim.pack hooks
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

-- Configs
require("keymaps")
require("options")
require("autocmds")
-- custom.lua is a file that can be created to override or add properties based on your local environment. This file
-- is not version controlled so each environment can add its own properties without conflict. The setup.sh script needs
-- to be executed to create the custom.lua file and prevent a config error. An added bonus of using the setup.sh script
-- is the auto sourcing of configs depending on your environment and your answer to prompts
require("custom")
