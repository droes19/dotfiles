return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = true,
  opts = {
    check_ts = true,
    enable_check_bracket_line = false,
    disable_filetype = { "TelescopePrompt", "vim" },
    fast_wrap = {
      map = "<M-e>",
      chars = { "{", "[", "(", '"', "'" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
      offset = 0, -- Offset from pattern match
      end_key = "$",
      keys = "qwertyuiopzxcvbnmasdfghjkl",
      check_comma = true,
      highlight = "Search",
    },
  },
}
