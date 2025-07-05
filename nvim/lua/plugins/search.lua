return {
  {
    "ibhagwan/fzf-lua",
    event = "VimEnter",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    config = function()
      require("fzf-lua").setup({
        defaults = {
          file_ignore_patterns = { ".git", "node_modules" },
        },
        files = {
          fd_opts = "--color=never --type f --hidden --follow --exclude .git --exclude node_modules",
        },
        grep = {
          rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden -g '!.git/' -g '!node_modules/'",
        },
      })

      local fzf = require("fzf-lua")
      vim.keymap.set("n", "<leader>sh", fzf.help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sk", fzf.keymaps, { desc = "[S]earch [K]eymaps" })
      vim.keymap.set("n", "<leader>sf", fzf.files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>ss", fzf.builtin, { desc = "[S]earch [S]elect FZF-Lua" })
      vim.keymap.set("n", "<leader>sw", fzf.grep_cword, { desc = "[S]earch current [W]ord" })
      vim.keymap.set("n", "<leader>sg", fzf.live_grep, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "<leader>sd", fzf.diagnostics_document, { desc = "[S]earch [D]iagnostics" })
      vim.keymap.set("n", "<leader>sr", fzf.resume, { desc = "[S]earch [R]esume" })
      vim.keymap.set("n", "<leader>s.", fzf.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set("n", "<leader>gb", fzf.git_branches, { desc = "[G]it [B]ranches" })
      vim.keymap.set("n", "<leader><leader>", fzf.buffers, { desc = "[ ] Find existing buffers" })

      vim.keymap.set("n", "<leader>/", function()
        fzf.blines({ fzf_opts = { ["--layout"] = "reverse-list" }, winopts = { preview = { hidden = "hidden" } } })
      end, { desc = "[/] Fuzzily search in current buffer" })

      vim.keymap.set("n", "<leader>s/", function()
        fzf.live_grep({ grep_open_files = true, prompt = "Live Grep in Open Files" })
      end, { desc = "[S]earch [/] in Open Files" })

      vim.keymap.set("n", "<leader>sn", function()
        fzf.files({ cwd = vim.fn.stdpath("config"), hidden = true })
      end, { desc = "[S]earch [N]eovim files" })
    end,
  },
}
