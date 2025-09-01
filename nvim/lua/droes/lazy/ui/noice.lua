return {
  "folke/noice.nvim",
  event = { "CmdlineEnter", "VeryLazy" },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      },
      progress = {
        enabled = false,
      },
      documentation = {
        view = "hover",
        opts = {
          lang = "markdown",
          replace = true,
          render = "plain",
          format = { "{message}" },
          win_options = { concealcursor = "n", conceallevel = 3 },
        },
      },
    },

    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = false,
    },

    health = {
      checker = false, -- Disable if it is annoying
    },

    smart_move = {
      enabled = true, -- noice tries to move out of the way of existing floating windows
      excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
    },
    routes = {
      -- Route long messages to split
      {
        filter = {
          event = "msg_show",
          min_height = 10,
        },
        view = "split",
      },
      -- Route search messages to mini view
      {
        filter = {
          event = "msg_show",
          kind = "search_count",
        },
        opts = { skip = true },
      },
      -- Hide written messages
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
      -- Hide yank messages
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "yanked",
        },
        opts = { skip = true },
      },
      -- Hide search wrap messages
      {
        filter = {
          event = "msg_show",
          kind = "wmsg",
          find = "search hit",
        },
        opts = { skip = true },
      },
    },
  },
  keys = require("droes.keymaps").get_noice_keymaps(),
  config = function(_, opts)
    require("noice").setup(opts)

    -- Show notification when starting macro recording
    vim.api.nvim_create_autocmd("RecordingEnter", {
      callback = function()
        local msg = string.format("Recording macro to register: %s", vim.fn.reg_recording())

        _MACRO_RECORDING_STATUS = true
        vim.notify(msg, vim.log.levels.INFO, {
          title = "Macro Recording",
          keep = function()
            return _MACRO_RECORDING_STATUS
          end,
        })
      end,
      group = vim.api.nvim_create_augroup("NoiceMacroNotfication", { clear = true }),
    })

    vim.api.nvim_create_autocmd("RecordingLeave", {
      callback = function()
        _MACRO_RECORDING_STATUS = false
        vim.notify("Macro recording completed!", vim.log.levels.INFO, {
          title = "Macro Recording End",
          icon = "✓",
          timeout = 2000,
        })
      end,
      group = vim.api.nvim_create_augroup("NoiceMacroNotficationDismiss", { clear = true }),
    })
  end,
}
