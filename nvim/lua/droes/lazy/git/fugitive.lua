return {
  "tpope/vim-fugitive",
  dependencies = { "tpope/vim-rhubarb" },
  cmd = { "Git", "GBrowse", "Gread", "Gwrite", "Gdiffsplit" },
  keys = require("droes.keymaps").get_git_enhanced_keymaps(),
}
