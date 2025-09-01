return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("lualine").setup({
      option = "tokyonight",
      sections = {
        lualine_c = { { "filename", path = 1 } },
      },
    })
  end,
}
