return {
  "stevearc/aerial.nvim",
  event = { "CmdlineEnter", "VeryLazy" },
  keys = require("droes.keymaps").get_aerial_keymaps(),
  config = function()
    require("aerial").setup({
      on_attach = function(bufnr)
        require("droes.keymaps").setup_aerial_buffer(bufnr)
      end,
    })
  end,
}
