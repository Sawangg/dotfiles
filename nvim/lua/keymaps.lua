-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local function map(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Toggle background transparency
vim.api.nvim_set_keymap("n", "TT", ":TransparentToggle<CR>", { noremap=true })

-- Disable arrow keys
map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Handle Azerty layout
map({ "n", "v" }, "à", "0", { silent = true })
map({ "n", "v" }, "&", "1", { silent = true })
map({ "n", "v" }, "é", "2", { silent = true })
map({ "n", "v" }, '"', "3", { silent = true })
map({ "n", "v" }, "'", "4", { silent = true })
map({ "n", "v" }, "(", "5", { silent = true })
map({ "n", "v" }, "-", "6", { silent = true })
map({ "n", "v" }, "è", "7", { silent = true })
map({ "n", "v" }, "_", "8", { silent = true })
map({ "n", "v" }, "ç", "9", { silent = true })

map({ "n", "v" }, "0", "à", { silent = true })
map({ "n", "v" }, "1", "&", { silent = true })
map({ "n", "v" }, "2", "é", { silent = true })
map({ "n", "v" }, "3", '"', { silent = true })
map({ "n", "v" }, "4", "'", { silent = true })
map({ "n", "v" }, "5", "(", { silent = true })
map({ "n", "v" }, "6", "-", { silent = true })
map({ "n", "v" }, "7", "è", { silent = true })
map({ "n", "v" }, "8", "_", { silent = true })
map({ "n", "v" }, "9", "ç", { silent = true })

map({ "n" }, "ù", "`", { silent = true })

map({ "n", "i" }, "§", "\\", { silent = true })
