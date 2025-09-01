return {
  "sindrets/diffview.nvim",
  event = { "CmdlineEnter", "VeryLazy" },
  config = function()
    require("diffview").setup({
      diff_binaries = false,
      enhanced_diff_hl = false,
      git_cmd = { "git" },
      use_icons = true,
    })
  end,
}
