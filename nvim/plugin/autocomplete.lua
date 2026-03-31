vim.pack.add({
  "https://github.com/fang2hou/blink-copilot",
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
})

require("blink.cmp").setup({
  keymap = { preset = "super-tab" },

  appearance = {
    nerd_font_variant = "mono",
  },

  sources = {
    default = { "copilot", "lsp", "path", "snippets", "buffer" },
    providers = {
      copilot = {
        name = "copilot",
        module = "blink-copilot",
        score_offset = 99,
        async = true,
      },
    },
  },

  completion = {
    ghost_text = { enabled = true },
  },

  signature = { enabled = true },
})
