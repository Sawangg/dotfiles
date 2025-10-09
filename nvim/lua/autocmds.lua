--  See `:help lua-guide-autocommands`

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    if vim.fn.has("wsl") == 1 then
      vim.fn.system("clip.exe", vim.fn.getreg('"'))
    end
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Open file explorer when starting Vim without a file",
  group = vim.api.nvim_create_augroup("OpenFolderView", { clear = true }),
  callback = function()
    if vim.fn.argc() == 0 and vim.bo.filetype ~= "man" then
      vim.defer_fn(function()
        require("oil").open()
      end, 1)
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    -- Highlight references when the cursor is on a symbol
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

    -- Auto-format on save
    if client and client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        buffer = event.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = event.buf, id = client.id })
        end,
      })
    end
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Return to last edit position when opening files",
  group = vim.api.nvim_create_augroup("last-position-jump", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
