vim.loader.enable()
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", --latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- Core functionality
    { import = "droes.lazy.core" },

    -- User interface
    { import = "droes.lazy.ui" },

    -- Git integration
    { import = "droes.lazy.git" },

    -- Text editing
    { import = "droes.lazy.editing" },

    -- Development tools
    { import = "droes.lazy.tools" },

    -- Miscellaneous
    { import = "droes.lazy.misc" },

    -- Individual files that don't fit categories
    { import = "droes.lazy" },
  },
  defaults = {
    lazy = true, -- Make all plugins lazy by default
  },
  install = {
    missing = true,
    colorscheme = { "catppuccin" }, -- Load colorscheme immediately
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "rplugin", -- Disable remote plugins
        "syntax", -- Use treesitter instead
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
  change_detection = {
    notify = false,
    enabled = false, -- Disable for faster startup
  },
  ui = {
    backdrop = 100,
    size = { width = 0.8, height = 0.8 },
  },
  rocks = {
    enabled = false,
  },
  -- Add profiling to identify slow plugins
  profiling = {
    loader = false,
    require = false,
  },
})
