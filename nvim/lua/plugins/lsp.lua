return {
  { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",

      -- Installer of LSP tools to stdpath
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      {
        "j-hui/fidget.nvim",
        opts = {
          notification = {
            window = {
              winblend = 0, -- No background
            },
          },
        },
      },

      -- Provide LuaLS with Neovim API
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    opts = {
      servers = {
        lua_ls = {},
      },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")

          -- Find references for the word under your cursor.
          map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")

          -- Jump to the implementation of the word under your cursor.
          map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")

          -- Jump to the type of the word under your cursor.
          map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")

          -- Fuzzy find all the symbols in your current document.
          map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")

          -- Fuzzy find all the symbols in your current workspace.
          map("<leader>ws", require("fzf-lua").lsp_workspace_symbols, "[W]orkspace [S]ymbols")

          -- Opens a popup that displays documentation about the word under your cursor
          map("K", vim.lsp.buf.hover, "Hover Documentation")

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

          -- Highlight references under cursor
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = opts.servers,
        automatic_enable = true,
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server = opts.servers[server_name] or {}
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
}
