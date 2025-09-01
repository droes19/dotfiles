return {
  "laytan/cloak.nvim",
  ft = "sh",
  event = "VeryLazy",
  config = function()
    require("cloak").setup({
      enabled = true,
      cloak_character = "*",
    })
  end,
}
