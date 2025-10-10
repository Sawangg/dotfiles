local M = {}

function M.mode()
  local mode_map = {
    ["n"] = { label = "NORMAL", hl = "StatuslineNormalMode" },
    ["i"] = { label = "INSERT", hl = "StatuslineInsertMode" },
    ["v"] = { label = "VISUAL", hl = "StatuslineVisualMode" },
    ["V"] = { label = "V-LINE", hl = "StatuslineVisualMode" },
    ["\22"] = { label = "V-BLOCK", hl = "StatuslineVisualMode" },
    ["c"] = { label = "COMMAND", hl = "StatuslineCommandMode" },
    ["s"] = { label = "SELECT", hl = "StatuslineVisualMode" },
    ["S"] = { label = "S-LINE", hl = "StatuslineVisualMode" },
    ["\19"] = { label = "S-BLOCK", hl = "StatuslineVisualMode" },
    ["R"] = { label = "REPLACE", hl = "StatuslineReplaceMode" },
    ["t"] = { label = "TERMINAL", hl = "StatuslineTerminalMode" },
  }

  local mode = vim.api.nvim_get_mode().mode
  local mode_info = mode_map[mode] or { label = "UNKNOWN", hl = "StatuslineNormalMode" }

  return string.format("%%#%s# %s %%*", mode_info.hl, mode_info.label)
end

function M.git_branch()
  local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
  if branch ~= "" then
    return string.format("%%#StatuslineGitBranch#  %s %%*", branch)
  end
  return ""
end

function M.filetype()
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if not ok or vim.bo.filetype == "" then
    return vim.bo.filetype ~= "" and " " .. vim.bo.filetype .. " " or ""
  end

  local filetype = vim.bo.filetype
  local buf_name = vim.api.nvim_buf_get_name(0)
  local name, ext = vim.fn.fnamemodify(buf_name, ":t"), vim.fn.fnamemodify(buf_name, ":e")

  local icon, icon_hl = devicons.get_icon(name, ext)
  if not icon then
    icon, icon_hl = devicons.get_icon_by_filetype(filetype, { default = true })
  end

  if icon and icon_hl then
    return string.format("%%#%s#%s %%*%s ", icon_hl, icon, filetype)
  end

  return " " .. filetype .. " "
end

function M.filesize()
  local size = vim.fn.wordcount().bytes
  local units = { "B", "KB", "MB", "GB" }
  local unit_idx = 1

  while size > 1024 and unit_idx < #units do
    size = size / 1024
    unit_idx = unit_idx + 1
  end

  return string.format("%%#StatuslineFilesize# %.1f%s %%*", size, units[unit_idx])
end

local statusline = {
  '%{%v:lua.require("statusline").mode()%}',
  '%{%v:lua.require("statusline").git_branch()%}',
  " %F%r%m ",
  "%=",
  '%{%v:lua.require("statusline").filetype()%}',
  '%{%v:lua.require("statusline").filesize()%}',
  "%#StatuslinePosition# %l:%c %*",
}

vim.o.statusline = table.concat(statusline, "")

local colors = require("catppuccin.palettes").get_palette()

vim.api.nvim_set_hl(0, "StatuslineNormalMode", { bg = colors.blue, fg = colors.base, bold = true })
vim.api.nvim_set_hl(0, "StatuslineInsertMode", { bg = colors.green, fg = colors.base, bold = true })
vim.api.nvim_set_hl(0, "StatuslineVisualMode", { bg = colors.mauve, fg = colors.base, bold = true })
vim.api.nvim_set_hl(0, "StatuslineCommandMode", { bg = colors.peach, fg = colors.base, bold = true })
vim.api.nvim_set_hl(0, "StatuslineReplaceMode", { bg = colors.red, fg = colors.base, bold = true })
vim.api.nvim_set_hl(0, "StatuslineTerminalMode", { bg = colors.pink, fg = colors.base, bold = true })
vim.api.nvim_set_hl(0, "StatuslineGitBranch", { bg = colors.surface1, fg = colors.text })
vim.api.nvim_set_hl(0, "StatuslineFilesize", { bg = colors.surface1, fg = colors.text })
vim.api.nvim_set_hl(0, "StatuslinePosition", { bg = colors.blue, fg = colors.base, bold = true })

return M
