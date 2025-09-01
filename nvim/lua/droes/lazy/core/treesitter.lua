return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      modules = {},
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "java",
        "javascript",
        "typescript",
        "html",
        "css",
        "json",
        "yaml",
        "bash",
        "python",
        "sql",
      },
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "markdown" },
      },
    })

    -- local group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true })
    --
    -- require("nvim-treesitter").setup()
    --
    -- local syntax_on = {
    --   -- typescript = true,
    --   -- java = true,
    -- }

    -- vim.api.nvim_create_autocmd("FileType", {
    --   group = group,
    --   callback = function(args)
    --     local bufnr = args.buf
    --     local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
    --     if not ok or not parser then
    --       return
    --     end
    --     pcall(vim.treesitter.start)
    --
    --     local ft = vim.bo[bufnr].filetype
    --     if syntax_on[ft] then
    --       vim.bo[bufnr].syntax = "on"
    --     end
    --   end,
    -- })
    --
    -- vim.api.nvim_create_autocmd("User", {
    --   pattern = "TSUpdate",
    --   callback = function()
    --     local parsers = require("nvim-treesitter.parsers")
    --
    --     parsers.lua = {
    --       tier = 0,
    --
    --       ---@diagnostic disable-next-line: missing-fields
    --       install_info = {
    --         -- path = "~/plugins/tree-sitter-lua",
    --         files = { "src/parser.c", "src/scanner.c" },
    --       },
    --     }
    --
    --     parsers.cram = {
    --       tier = 0,
    --
    --       ---@diagnostic disable-next-line: missing-fields
    --       install_info = {
    --         -- path = "~/git/tree-sitter-cram",
    --         files = { "src/parser.c" },
    --       },
    --     }
    --
    --     parsers.reason = {
    --       tier = 0,
    --
    --       ---@diagnostic disable-next-line: missing-fields
    --       install_info = {
    --         url = "https://github.com/reasonml-editor/tree-sitter-reason",
    --         files = { "src/parser.c", "src/scanner.c" },
    --         branch = "master",
    --       },
    --     }
    --   end,
    -- })
    -- local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    -- treesitter_parser_config.templ = {
    --   install_info = {
    --     url = "https://github.com/vrischmann/tree-sitter-templ.git",
    --     files = { "src/parser.c", "src/scanner.c" },
    --     branch = "master",
    --   },
    -- }
    --
    -- vim.treesitter.language.register("templ", "templ")
  end,
}
