vim.pack.add({
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/nvim-tree/nvim-web-devicons",
})

local fzf = require("fzf-lua")

fzf.setup({
  hls = {
    normal = "Normal",
    border = "Normal",
    preview_normal = "Normal",
    preview_border = "Normal",
  },
})

-- Fzf keymaps for lsp & searc 
local map = vim.keymap.set

map("n", "gd", fzf.lsp_definitions, { desc = "[G]oto [D]efinition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
map("n", "gr", fzf.lsp_references, { desc = "[G]oto [R]eferences" })
map("n", "gI", fzf.lsp_implementations, { desc = "[G]oto [I]mplementation" })
map("n", "<leader>D", fzf.lsp_typedefs, { desc = "Type [D]efinition" })
map("n", "<leader>ds", fzf.lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })
map("n", "<leader>ws", fzf.lsp_workspace_symbols, { desc = "[W]orkspace [S]ymbols" })

map("n", "<leader>sh", fzf.help_tags, { desc = "[S]earch [H]elp" })
map("n", "<leader>sk", fzf.keymaps, { desc = "[S]earch [K]eymaps" })
map("n", "<leader>sf", fzf.files, { desc = "[S]earch [F]iles" })
map("n", "<leader>ss", fzf.builtin, { desc = "[S]earch [S]elect FZF-Lua" })
map("n", "<leader>sw", fzf.grep_cword, { desc = "[S]earch current [W]ord" })
map("n", "<leader>sg", fzf.live_grep, { desc = "[S]earch by [G]rep" })
map("n", "<leader>sd", fzf.diagnostics_document, { desc = "[S]earch [D]iagnostics" })
map("n", "<leader>sr", fzf.resume, { desc = "[S]earch [R]esume" })
map("n", "<leader>sm", fzf.marks, { desc = "[S]earch [M]arks" })
map("n", "<leader>s.", fzf.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
map("n", "<leader><leader>", fzf.buffers, { desc = "[ ] Find existing buffers" })

map("n", "<leader>/", function()
  fzf.blines({ fzf_opts = { ["--layout"] = "reverse-list" }, winopts = { preview = { hidden = true } } })
end, { desc = "[/] Fuzzily search in current buffer" })

map("n", "<leader>s/", function()
  fzf.live_grep({ grep_open_files = true, prompt = "Live Grep in Open Files" })
end, { desc = "[S]earch [/] in Open Files" })

map("n", "<leader>sn", function()
  fzf.files({ cwd = vim.fn.stdpath("config"), hidden = true })
end, { desc = "[S]earch [N]eovim files" })
