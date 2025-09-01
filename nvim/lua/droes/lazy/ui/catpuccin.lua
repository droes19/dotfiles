return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  opts = {
    integrations = {
      aerial = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      notify = true,
      mini = {
        enabled = true,
        indentscope_color = "",
      },
      harpoon = true,
      telescope = {
        enabled = true,
      },
    },
  },
  config = function()
    vim.cmd.colorscheme("catppuccin")
  end,
}
