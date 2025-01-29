-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Open file explorer when starting Vim without a file",
  group = vim.api.nvim_create_augroup("OpenFolderView", { clear = true }),
  callback = function()
    if vim.fn.argc() == 0 then
      vim.defer_fn(function()
        require("oil").open()
      end, 1)
    end
  end,
})
