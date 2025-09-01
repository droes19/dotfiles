return {
  "stevearc/oil.nvim",
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  priority = 1000,
  config = function()
    CustomOilBar = function()
      local path = vim.fn.expand("%")
      path = path:gsub("oil://", "")

      return "  " .. vim.fn.fnamemodify(path, ":.")
    end

    require("oil").setup({
      columns = { "icon" },
      keymaps = require("droes.keymaps").get_oil_keymaps(),
      win_options = {
        winbar = "%{v:lua.CustomOilBar()}",
      },
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          local folder_skip = { "dev-tools.locks", "dune.lock", "_build" }
          return vim.tbl_contains(folder_skip, name)
        end,
      },
    })
  end,
}
