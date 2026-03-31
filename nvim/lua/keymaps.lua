--  See `:help vim.keymap.set()`

local map = vim.keymap.set

map("n", "<Esc>", "<CMD>nohlsearch<CR>")

map("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open [O]il" })

map("n", "<leader>gp", "<CMD>Gitsigns preview_hunk_inline<CR>")
map("n", "<leader>gb", "<CMD>Gitsigns toggle_current_line_blame<CR>")

map("n", "<leader>f", vim.lsp.buf.format, { desc = "[F]ormat current buffer" })

-- Diagnostic keymaps
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Center screen when jumping
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Better indenting in visual mode
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Plugin management
map("n", "<leader>pu", function() vim.pack.update() end, { desc = "[P]lugin [U]pdate" })
map("n", "<leader>pl", function() vim.pack.update(nil, { offline = true }) end, { desc = "[P]lugin [L]ist" })
