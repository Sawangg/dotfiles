-- See `:help vim.opt`
-- For more options, you can see `:help option-list`

-- Basic settings
vim.o.number = true         -- Show line numbers
vim.o.relativenumber = true -- Enable relative line numbers
vim.o.cursorline = true     -- Highlight current line where the cursor is
vim.o.scrolloff = 10        -- Keep 10 lines above/below cursor
vim.o.sidescrolloff = 8     -- Keep 8 columns left/right of cursor
vim.o.textwidth = 120       -- Set the word wrap to 120 characters

-- Indentation settings
vim.o.tabstop = 2        -- Tab width
vim.o.shiftwidth = 2     -- Indent width
vim.o.softtabstop = 2    -- Soft tab stop
vim.o.expandtab = true   -- Use spaces instead of tabs
vim.o.smartindent = true -- Smart auto-indenting
vim.o.autoindent = true  -- Copy indent from current line
vim.o.breakindent = true -- Enable break indent

-- Search settings
vim.o.ignorecase = true    -- Case insensitive search
vim.o.smartcase = true     -- Case-sensitive if uppercase in search
vim.o.hlsearch = true      -- Highlight search results
vim.o.incsearch = true     -- Show matches as you type
vim.o.inccommand = "split" -- Preview of substitutions as you type

-- Visual settings
vim.o.termguicolors = true -- Enable 24-bit colors
vim.o.signcolumn = "yes" -- Always show sign column
vim.o.showmatch = true -- Highlight matching brackets
vim.o.cmdheight = 1 -- Command line height
vim.o.pumblend = 10 -- Pop-up menu transparency
vim.o.winblend = 0 -- Floating window transparency
vim.o.winborder = "rounded" -- Rounded borders for floating windows
vim.o.showmode = false -- Don't show the mode (we're using a custom statusline)
vim.o.list = true -- Show invisible characters
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- List of characters to show

-- File handling
vim.o.updatetime = 250 -- Faster completion
vim.o.timeoutlen = 300 -- Key timeout duration
vim.o.undofile = true  -- Save undo history
vim.o.autoread = true  -- Auto reload files changed outside vim

-- Behavior settings
vim.o.encoding = "UTF-8"                -- Set encoding
vim.opt.clipboard:append("unnamedplus") -- Use system clipboard
vim.o.swapfile = false                  -- Disable swap files
vim.o.errorbells = false                -- No error bells
vim.o.confirm = true                    -- Ask what do so about unsaved changes

-- Split behavior
vim.o.splitright = true -- Vertical splits go right
vim.o.splitbelow = true -- Horizontal splits go below
