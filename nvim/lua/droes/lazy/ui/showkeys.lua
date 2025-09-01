return {
  "nvzone/showkeys",
  event = "VeryLazy",
  -- cmd = "ShowkeysToggle",
  opts = {
    maxkeys = 10,
  },
  config = function(_, opts)
    require("showkeys").setup(opts)
    require("showkeys").toggle()
    -- vim.keymap.set("n", "<leader>sk", "<cmd>ShowkeysToggle<cr>", { desc = "Showkeys Toggle" })
  end,
}
