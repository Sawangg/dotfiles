--  See `:help vim.keymap.set()`

local map = vim.keymap.set

map("n", "<Esc>", "<CMD>nohlsearch<CR>")

map("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open [O]il" })

map("n", "<leader>ng", "<CMD>Neogit<CR>", { desc = "Open [N]eo[g]it" })

map("n", "<leader>gp", "<CMD>Gitsigns preview_hunk_inline<CR>")
map("n", "<leader>gb", "<CMD>Gitsigns toggle_current_line_blame<CR>")

-- Diagnostic keymaps
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Center the page when using <c-d> and <c-u>
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
