return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
  },
  keys = require("droes.keymaps").get_which_key_keymaps(),
}
