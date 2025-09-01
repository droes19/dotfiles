return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")
        if client.name == "jdtls" then
          local function create_cmd(name, command, cmdopts)
            vim.api.nvim_buf_create_user_command(bufnr, name, command, cmdopts or {})
          end
          create_cmd("JdtSetRuntime", "lua require('jdtls').set_runtime(<f-args>)", {
            nargs = "?",
            complete = "custom,v:lua.require'jdtls'._complete_set_runtime",
          })
        end
      end,
    })
  end,
}
