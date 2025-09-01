return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      current_line_blame = true,
      current_line_blame_formatter = "<author>, (<author_time:%d-%m-%Y %H:%M:%S>) <author_time:%R> - <summary>",
      on_attach = function(bufnr)
        require("droes.keymaps").setup_git(bufnr)
      end,
    })
  end,
}
