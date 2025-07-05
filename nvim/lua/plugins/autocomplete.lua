return {
  { -- Autocompletion
    "saghen/blink.cmp",
    dependencies = { "fang2hou/blink-copilot", "rafamadriz/friendly-snippets" },
    version = "*",

    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      keymap = { preset = "super-tab" },

      appearance = {
        nerd_font_variant = "mono",
      },

      sources = {
        default = { "lazydev", "copilot", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
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
