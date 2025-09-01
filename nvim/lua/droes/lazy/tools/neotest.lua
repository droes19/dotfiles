return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "antoinemadec/FixCursorHold.nvim",
  },
  cmd = { "Neotest" },
  keys = require("droes.keymaps").get_neotest_keymaps(),
  opts = {},
}
