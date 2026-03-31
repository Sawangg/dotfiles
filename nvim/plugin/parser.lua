vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

-- Install missing parsers on startup.
local ensure_installed = { "bash", "lua", "luadoc", "markdown", "markdown_inline", "vim", "vimdoc" }

vim.schedule(function()
  local ok, config = pcall(require, "nvim-treesitter.config")
  if not ok then
    return
  end

  local installed = config.get_installed()
  local missing = vim.tbl_filter(function(lang)
    return not vim.list_contains(installed, lang)
  end, ensure_installed)

  if #missing > 0 then
    require("nvim-treesitter.install").install(missing, { summary = true })
  end
end)
