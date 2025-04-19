return {
  { -- Note taking plugin using obsidian
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      -- Path to your vaults
      ui = { enable = false },
      workspaces = {
        {
          name = "main",
          path = "~/Documents/vaults/Main/",
          -- This organization is specific to this vault
          overrides = {
            notes_subdir = "0-inbox",
            new_notes_location = "notes_subdir",

            disable_frontmatter = true,
            templates = {
              folder = "99-template/",
            },
            attachments = {
              img_folder = "98-attachments/",
            },
          },
        },
      },
    },
  },
  { -- Better Markdown rendering
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },
}
