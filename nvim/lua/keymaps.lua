-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable arrow keys
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Handle Azerty layout
vim.keymap.set({ "n", "v" }, "à", "0", { silent = true })
vim.keymap.set({ "n", "v" }, "&", "1", { silent = true })
vim.keymap.set({ "n", "v" }, "é", "2", { silent = true })
vim.keymap.set({ "n", "v" }, '"', "3", { silent = true })
vim.keymap.set({ "n", "v" }, "'", "4", { silent = true })
vim.keymap.set({ "n", "v" }, "(", "5", { silent = true })
vim.keymap.set({ "n", "v" }, "-", "6", { silent = true })
vim.keymap.set({ "n", "v" }, "è", "7", { silent = true })
vim.keymap.set({ "n", "v" }, "_", "8", { silent = true })
vim.keymap.set({ "n", "v" }, "ç", "9", { silent = true })

vim.keymap.set({ "n", "v" }, "0", "à", { silent = true })
vim.keymap.set({ "n", "v" }, "1", "&", { silent = true })
vim.keymap.set({ "n", "v" }, "2", "é", { silent = true })
vim.keymap.set({ "n", "v" }, "3", '"', { silent = true })
vim.keymap.set({ "n", "v" }, "4", "'", { silent = true })
vim.keymap.set({ "n", "v" }, "5", "(", { silent = true })
vim.keymap.set({ "n", "v" }, "6", "-", { silent = true })
vim.keymap.set({ "n", "v" }, "7", "è", { silent = true })
vim.keymap.set({ "n", "v" }, "8", "_", { silent = true })
vim.keymap.set({ "n", "v" }, "9", "ç", { silent = true })

vim.keymap.set({ "n" }, "ù", "`", { silent = true })

vim.keymap.set({ "n", "i" }, "§", "\\", { silent = true })
