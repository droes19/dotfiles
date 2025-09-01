return {
  "ThePrimeagen/refactoring.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    prompt_func_return_type = {
      go = true,
      cpp = true,
      c = true,
      java = true,
    },
    -- prompt for function parameters
    prompt_func_param_type = {
      go = true,
      cpp = true,
      c = true,
      java = true,
    },
  },
  keys = require("droes.keymaps").get_refactoring_keymaps(),
}
