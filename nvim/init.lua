-- Import configs
require("keymaps")
require("options")
require("autocmds")

-- Set <space> as the leader key
--  See `:help mapleader`
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Nerd fonts support
vim.g.have_nerd_font = true

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Set up lazy and auto import the plugins folder
require("lazy").setup("plugins", {
  change_detection = {
    notify = false,
  },
})

