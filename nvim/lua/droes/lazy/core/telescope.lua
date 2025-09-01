local data = assert(vim.fn.stdpath("data")) --[[@as string]]
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-smart-history.nvim",
    "kkharji/sqlite.lua",
  },
  keys = require("droes.keymaps").get_telescope_keymaps(),
  config = function()
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = { "dune.lock", "node_modules", "%.git/", "target/" },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden", -- Search hidden files
        },
      },
      extensions = {
        wrap_results = true,
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
        history = {
          path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
          limit = 100,
        },
      },
      pickers = {
        find_files = {
          hidden = true, -- Show hidden files
        },
      },
    })

    pcall(require("telescope").load_extension, "ui-select")
    pcall(require("telescope").load_extension, "smart_history")
  end,
}
