-- create a note with a default template because it is not supported by obsidian.nvim
local function createNoteWithDefaultTemplate()
  local TEMPLATE_FILENAME = "template"
  local obsidian = require("obsidian").get_client()
  local utils = require("obsidian.util")

  -- prompt for note title
  -- @see: borrowed from obsidian.command.new
  local note
  local title = utils.input("Enter title or path (optional): ")
  if not title then
    return
  elseif title == "" then
    title = nil
  end
  -- !! added .md so I only need to write the title without the extension (bypass default name)
  note = obsidian:create_note({ title = title .. ".md", no_write = true })

  if not note then
    return
  end
  obsidian:open_note(note, { sync = true })
  obsidian:write_note_to_buffer(note, { template = TEMPLATE_FILENAME })
  -- hack: delete empty lines before frontmatter; template seems to be injected at line 2
  vim.api.nvim_buf_set_lines(0, 0, 1, false, {})
end

return {
  { -- Note taking plugin using obsidian
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      -- Path to your vaults
      ui = { enable = { false } },
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
              img_folder = "98-attachments/"
            }
          }
        }
      },
      vim.keymap.set("n", "<leader>nn", createNoteWithDefaultTemplate, { desc = "[N]ew Obsidian [N]ote" })
    }
  },
  { -- Better Markdown rendering
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  }
}
