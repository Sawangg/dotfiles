-- [[ Keymaps ]]
--  See `:help vim.keymap.set()`

local function map(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.jump({ count = -1, float = true }), { desc = "Go to previous [D]iagnostic message" })
map("n", "]d", vim.diagnostic.jump({ count = 1, float = true }), { desc = "Go to next [D]iagnostic message" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Oil bind
map("n", "<leader>o", ":Oil<CR>", { desc = "Open [O]il" })
