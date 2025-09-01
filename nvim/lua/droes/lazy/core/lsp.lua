return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    -- lazy = false,
    dependencies = {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
      },
      { "Bilal2453/luvit-meta", lazy = true },
      { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
      { "hrsh7th/cmp-buffer", event = "InsertEnter" },
      { "hrsh7th/cmp-path", event = "InsertEnter" },
      { "hrsh7th/cmp-cmdline", event = "CmdlineEnter" },
      { "hrsh7th/nvim-cmp", event = "InsertEnter" },
      {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        run = "make install_jsregexp",
        dependencies = {
          "rafamadriz/friendly-snippets",
        },
        opts = {},
      },
      { "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
      { "onsails/lspkind.nvim", event = "InsertEnter" },
      { "roobert/tailwindcss-colorizer-cmp.nvim", event = "InsertEnter" },
      { "j-hui/fidget.nvim", event = "LspAttach", opts = {} },
      { "b0o/SchemaStore.nvim", ft = { "json", "yaml" } },
      { "stevearc/conform.nvim", event = { "BufWritePre" } },
      { "mason-org/mason-lspconfig.nvim", event = "BufReadPre" },
      {
        "mason-org/mason.nvim",
        cmd = "Mason",
        opts = {
          registries = {
            "github:mason-org/mason-registry",
            "github:nvim-java/mason-registry",
          },
        },
      },
    },
    config = function()
      -- Load the LuaSnip snippets
      vim.defer_fn(function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end, 100)

      local servers = require("droes.utils.util").get_files_and_value_as_table_from("droes/lazy/core/server")

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      if pcall(require, "cmp_nvim_lsp") then
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
      end

      local ensure_installed = {}
      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        config = vim.tbl_deep_extend("force", {}, {
          capabilities = capabilities,
        }, config)

        vim.lsp.config(name, config)
        table.insert(ensure_installed, name)
      end

      ---@type boolean | table
      local automatic_enable = true

      -- Check if we're in an Angular project
      local function is_angular_project()
        local cwd = vim.loop.cwd()
        local found = vim.fs.find({ "angular.json", "nx.json" }, {
          upward = true,
          path = cwd,
          stop = vim.loop.os_homedir(),
        })
        return #found > 0
      end

      -- If not Angular, exclude angularls from auto-enable
      if not is_angular_project() then
        automatic_enable = { exclude = { "angularls" } }
      end

      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        automatic_enable = automatic_enable,
      })
      local disable_semantic_tokens = {
        lua = true,
      }
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

          local settings = servers[client.name]
          if type(settings) ~= "table" then
            settings = {}
          end

          require("droes.keymaps").setup_lsp(bufnr)

          local filetype = vim.bo[bufnr].filetype
          if disable_semantic_tokens[filetype] then
            client.server_capabilities.semanticTokensProvider = nil
          end

          -- Override server capabilities
          if settings.server_capabilities then
            for k, v in pairs(settings.server_capabilities) do
              if v == vim.NIL then
                ---@diagnostic disable-next-line: cast-local-type
                v = nil
              end

              client.server_capabilities[k] = v
            end
          end
        end,
      })

      require("droes.keymaps").setup_diagnostic()

      local ensure_installed_non_lsp = {
        "stylua",
        "prettier",
        "prettierd",
        "eslint_d",
        "google-java-format",
      }
      require("droes.utils.mason").ensure_installed(ensure_installed_non_lsp)

      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
          html = { "prettier" },
          htmlangular = { "prettierd" },
          json = { "prettierd" },
          java = { "google-java-format" },
          typescript = { "prettierd" },
          nu = { "topiary_nu" },
        },
        formatters = {
          topiary_nu = {
            command = "topiary",
            args = { "format", "--language", "nu" },
          },
        },
      })

      require("droes.keymaps").setup_formatting()

      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("custom-conform", { clear = true }),
        callback = function(args)
          require("conform").format({
            bufnr = args.buf,
            lsp_fallback = true,
            quiet = true,
            async = true,
          })
        end,
      })

      vim.opt.completeopt = { "menu", "menuone", "noselect" }
      vim.opt.shortmess:append("c")

      local lspkind = require("lspkind")
      lspkind.init({
        symbol_map = {
          Copilot = "",
        },
      })

      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

      local kind_formatter = lspkind.cmp_format({
        mode = "symbol_text",
        menu = {
          buffer = "[buf]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[api]",
          path = "[path]",
          luasnip = "[snip]",
          gh_issues = "[issues]",
          tn = "[TabNine]",
          eruby = "[erb]",
        },
      })

      -- Add tailwindcss-colorizer-cmp as a formatting source
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })

      local cmp = require("cmp")

      cmp.setup({
        sources = {
          {
            name = "lazydev",
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = "copilot" },
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
        },
        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-y>"] = cmp.mapping(
            cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            }),
            { "i", "c" }
          ),
          ["<C-space>"] = cmp.mapping.complete,
        },

        -- Enable luasnip to handle snippet expansion for nvim-cmp
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },

        formatting = {
          fields = { "abbr", "kind", "menu" },
          expandable_indicator = true,
          format = function(entry, vim_item)
            -- Lspkind setup for icons
            vim_item = kind_formatter(entry, vim_item)

            -- Tailwind colorizer setup
            vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)

            return vim_item
          end,
        },

        sorting = {
          priority_weight = 2,
          comparators = {
            -- require("copilot_cmp.comparators").prioritize,

            -- Below is the default comparitor list and order for nvim-cmp
            cmp.config.compare.offset,
            -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      })
    end,
  },
}
