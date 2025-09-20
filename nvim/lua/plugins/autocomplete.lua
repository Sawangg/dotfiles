return {
  { -- Autocompletion
    "saghen/blink.cmp",
    dependencies = { "fang2hou/blink-copilot" },
    version = "*",
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
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
    },
    opts_extend = { "sources.default" },
  },
}
