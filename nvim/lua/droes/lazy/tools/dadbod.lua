return {
  "tpope/vim-dadbod",
  ft = { "sql", "mysql", "plsql", "pgsql", "sqlite" },
  dependencies = {
    "kristijanhusak/vim-dadbod-ui",
    "kristijanhusak/vim-dadbod-completion",
  },
  config = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}
