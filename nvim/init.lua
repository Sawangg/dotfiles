-- Sawangs' nvim config

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

-- Install `lazy.nvim` plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set up lazy and auto import the plugin's folder
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  rocks = {
    enabled = false,
  },
})

-- Then import configs
require("keymaps")
require("options")
require("autocmds")
-- custom.lua is a file that can be created to override or add properties based on your local environment. This file
-- is not version controlled so each environment can add its own properties without conflict. The setup.sh script needs
-- to be executed to create the custom.lua file and prevent a config error. An added bonus of using the setup.sh script
-- is the auto sourcing of configs depending on your environment and your answer to prompts
require("custom")
