vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

local lint = require("lint")

lint.linters_by_ft = {
  yaml = { "yamllint" },
}

vim.keymap.set("n", "<leader>l", function()
  lint.try_lint()
end, { desc = "[L]int buffer" })

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("nvim_lint", { clear = true }),
  callback = function()
    if vim.bo.modifiable then
      lint.try_lint()
    end
  end,
})
