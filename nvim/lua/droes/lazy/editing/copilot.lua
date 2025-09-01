return {
  "github/copilot.vim",
  event = "InsertEnter",
  keys = require("droes.keymaps").get_copilot_keymaps(),
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_filetypes = {
      ["*"] = false,
      ["javascript"] = true,
      ["typescript"] = true,
      ["lua"] = true,
      ["java"] = true,
      ["python"] = true,
    }
  end,
}
