return {
  {
    "ibhagwan/fzf-lua",
    event = "VimEnter",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    config = function()
      local fzf = require("fzf-lua")

      fzf.setup({
        hls = {
          normal = "Normal",
          border = "Normal",
          preview_normal = "Normal",
          preview_border = "Normal",
        },
      })

      local map = vim.keymap.set

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
    end,
  },
}
