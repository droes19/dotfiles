local opt = vim.opt

opt.number = true
opt.relativenumber = true

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Decrease update time
opt.updatetime = 50

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300
opt.ttimeoutlen = 10
opt.keymap = ""

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10
opt.wrap = false

vim.g.loaded_netrw = 1 -- Disable netrw (you have Oil)
vim.g.loaded_netrwPlugin = 1

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
