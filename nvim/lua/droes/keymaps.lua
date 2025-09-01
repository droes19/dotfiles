local function defer_setup(setup_fn, delay)
  delay = delay or 100
  vim.defer_fn(setup_fn, delay)
end

-- ============================================================================
-- UNIFIED KEYMAP HELPER FUNCTION
-- ============================================================================
local function map(mode, lhs, rhs, opts, bufnr)
  opts = opts or {}
  if bufnr ~= nil then
    opts.buffer = bufnr
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- ============================================================================
-- LEADER KEYS
-- ============================================================================
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- ============================================================================
-- CORE KEYMAPS (Always Active)
-- ============================================================================

-- System & Configuration
map("n", "<space><space>", "<cmd>so<CR>", { desc = "Reload configuration" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Navigation Training Wheels
map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>', { desc = "Remind to use h" })
map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>', { desc = "Remind to use l" })
map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>', { desc = "Remind to use k" })
map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>', { desc = "Remind to use j" })

-- Quick Actions
map("i", ":w", "<Esc>", { desc = "Exit insert mode (when trying to save)" })
map("t", "<C-H>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

map({ "n", "v" }, "<space>p", [["+p]])
map({ "n", "v" }, "<space>y", [["+y]])
map("n", "<space>Y", [["+Y]])
-- ============================================================================
-- WINDOW MANAGEMENT
-- ============================================================================
map("n", "<M-h>", "<C-w><C-h>", { desc = "Move focus to left window" })
map("n", "<M-l>", "<C-w><C-l>", { desc = "Move focus to right window" })
map("n", "<M-j>", "<C-w><C-j>", { desc = "Move focus to lower window" })
map("n", "<M-k>", "<C-w><C-k>", { desc = "Move focus to upper window" })

-- ============================================================================
-- FILE & NAVIGATION
-- ============================================================================
map("n", "<space>b", "<CMD>Oil<CR>", { desc = "Open parent directory" })
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- ============================================================================
-- TEXT EDITING & MANIPULATION
-- ============================================================================

-- Move Lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better Navigation
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Search & Replace
map(
  "n",
  "<space>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Search and replace word under cursor" }
)

-- Remap repeat opposite f,t,F,T. cause comma ',' is used as leader key
map("n", "<leader>;", ",", { desc = "Repeat last f/t/F/T search (opposite direction)" })

map("n", "<NL>", "-", { desc = "Go to previous line (with -)" })
-- ============================================================================
-- LANGUAGE-SPECIFIC SNIPPETS
-- ============================================================================

-- Java Snippets
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    map("i", "sout", "System.out.println();<Esc>hi", { buffer = true, desc = "System.out.println snippet" })
  end,
})

-- TypeScript/JavaScript Snippets
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  callback = function()
    map("i", "clog", "console.log();<Esc>hi", { buffer = true, desc = "console.log snippet" })
  end,
})

-- ============================================================================
-- PLUGIN KEYMAPS FOR LAZY LOADING
-- ============================================================================

-- Core Plugins
local function get_telescope_keymaps()
  return {
    {
      "<space>ff",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "Find files",
    },
    {
      "<space>fgf",
      function()
        require("telescope.builtin").git_files()
      end,
      desc = "Find git files",
    },
    {
      "<space>fh",
      function()
        require("telescope.builtin").help_tags()
      end,
      desc = "Find help tags",
    },
    {
      "<space>fl",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Live grep",
    },
    {
      "<space>@",
      function()
        require("telescope.builtin").registers()
      end,
      desc = "Show registers",
    },
    {
      "<space>lk",
      function()
        require("telescope.builtin").keymaps()
      end,
      desc = "Show keymaps",
    },
    {
      "<space>lc",
      function()
        require("telescope.builtin").colorscheme()
      end,
      desc = "Change colorscheme",
    },
    {
      "<space>lcm",
      function()
        require("telescope.builtin").commands()
      end,
      desc = "Show commands",
    },
    {
      "<space>lac",
      function()
        require("telescope.builtin").autocommands()
      end,
      desc = "Show autocommands",
    },
  }
end

local function get_harpoon_keymaps()
  return {
    {
      "<space>a",
      function()
        require("harpoon"):list():add()
      end,
      desc = "Add file to harpoon",
    },
    {
      "<space>e",
      function()
        require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
      end,
      desc = "Toggle harpoon menu",
    },
    {
      "<space>1",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "Go to harpoon file 1",
    },
    {
      "<space>2",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "Go to harpoon file 2",
    },
    {
      "<space>3",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "Go to harpoon file 3",
    },
    {
      "<space>4",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "Go to harpoon file 4",
    },
    {
      "<space>5",
      function()
        require("harpoon"):list():select(5)
      end,
      desc = "Go to harpoon file 5",
    },
    {
      "<M-p>",
      function()
        require("harpoon"):list():prev()
      end,
      desc = "Previous harpoon file",
    },
    {
      "<M-n>",
      function()
        require("harpoon"):list():next()
      end,
      desc = "Next harpoon file",
    },
  }
end

-- Development Tools
local function get_trouble_keymaps()
  return {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
  }
end

local function get_aerial_keymaps()
  return {
    { "<leader>a", "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial" },
  }
end

local function get_refactoring_keymaps()
  return {
    {
      "<leader>re",
      function()
        return require("refactoring").refactor("Extract Function")
      end,
      mode = { "n", "x" },
      expr = true,
      desc = "Extract function",
    },
    {
      "<leader>rf",
      function()
        return require("refactoring").refactor("Extract Function To File")
      end,
      mode = { "n", "x" },
      expr = true,
      desc = "Extract function to file",
    },
    {
      "<leader>rv",
      function()
        return require("refactoring").refactor("Extract Variable")
      end,
      mode = { "n", "x" },
      expr = true,
      desc = "Extract variable",
    },
    {
      "<leader>rI",
      function()
        return require("refactoring").refactor("Inline Function")
      end,
      mode = { "n", "x" },
      expr = true,
      desc = "Inline function",
    },
    {
      "<leader>ri",
      function()
        return require("refactoring").refactor("Inline Variable")
      end,
      mode = { "n", "x" },
      expr = true,
      desc = "Inline variable",
    },
    {
      "<leader>rr",
      function()
        return require("refactoring").refactor("Rename Symbol")
      end,
      mode = { "n", "x" },
      expr = true,
      desc = "Rename symbol",
    },
    {
      "<leader>rbb",
      function()
        return require("refactoring").refactor("Extract Block")
      end,
      mode = { "n", "x" },
      expr = true,
      desc = "Extract block",
    },
    {
      "<leader>rbf",
      function()
        return require("refactoring").refactor("Extract Block To File")
      end,
      mode = { "n", "x" },
      expr = true,
      desc = "Extract block to file",
    },
  }
end

local function get_hlslens_keymaps()
  return {
    {
      "n",
      [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zz]],
      desc = "Next search result (centered with hlslens)",
    },
    {
      "N",
      [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zz]],
      desc = "Previous search result (centered with hlslens)",
    },
  }
end

-- Git Tools
local function get_neogit_keymaps()
  return {
    {
      "<leader>g",
      function()
        require("neogit").open({ kind = "split" })
      end,
      desc = "Open Neogit",
    },
  }
end

local function get_git_enhanced_keymaps()
  return {
    { "<leader>gB", "<cmd>GBrowse<cr>", desc = "Git Browse" },
    { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git Diff Split" },
    { "<leader>gr", "<cmd>Gread<cr>", desc = "Git Read (checkout)" },
    { "<leader>gw", "<cmd>Gwrite<cr>", desc = "Git Write (stage)" },
  }
end

-- UI Enhancements
local function get_noice_keymaps()
  return {
    {
      "<S-Enter>",
      function()
        require("noice").redirect(vim.fn.getcmdline())
      end,
      mode = "c",
      desc = "Redirect Cmdline",
    },
    {
      "<leader>nl",
      function()
        require("noice").cmd("last")
      end,
      desc = "Noice Last Message",
    },
    {
      "<leader>nh",
      function()
        require("noice").cmd("history")
      end,
      desc = "Noice History",
    },
    {
      "<leader>na",
      function()
        require("noice").cmd("all")
      end,
      desc = "Noice All",
    },
    {
      "<leader>nd",
      function()
        require("noice").cmd("dismiss")
      end,
      desc = "Dismiss All",
    },
    {
      "<leader>nt",
      function()
        require("noice").cmd("pick")
      end,
      desc = "Noice Picker",
    },
    {
      "<C-f>",
      function()
        if not require("noice.lsp").scroll(4) then
          return "<C-f>"
        end
      end,
      mode = { "i", "n", "s" },
      silent = true,
      expr = true,
      desc = "Scroll Forward",
    },
    {
      "<C-b>",
      function()
        if not require("noice.lsp").scroll(-4) then
          return "<C-b>"
        end
      end,
      mode = { "i", "n", "s" },
      silent = true,
      expr = true,
      desc = "Scroll Backward",
    },
  }
end

local function get_which_key_keymaps()
  return {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  }
end

-- Editing Plugins
local function get_copilot_keymaps()
  return {
    {
      "<C-J>",
      'copilot#Accept("\\<CR>")',
      mode = "i",
      expr = true,
      replace_keycodes = false,
      desc = "Accept Copilot suggestion",
    },
  }
end

-- Testing & Utilities
local function get_neotest_keymaps()
  return {
    {
      "<leader>tn",
      function()
        require("neotest").run.run()
      end,
      desc = "Run Neotest",
    },
    {
      "<leader>tN",
      function()
        require("neotest").run.run({ suite = true })
      end,
      desc = "Run Neotest Suite",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle Neotest Summary",
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open({ enter = true })
      end,
      desc = "Open Neotest Output",
    },
  }
end

local function get_todo_keymaps()
  return {
    {
      "<leader>td",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next TODO comment",
    },
    {
      "<leader>tD",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous TODO comment",
    },
    {
      "<leader>tl",
      function()
        require("todo-comments").list()
      end,
      desc = "List TODO comments",
    },
  }
end

local function get_persistence_keymaps()
  return {
    {
      "<leader>ps",
      function()
        require("persistence").load({ last = true })
      end,
      desc = "Restore last session",
    },
    {
      "<leader>pl",
      function()
        require("persistence").load()
      end,
      desc = "Load session",
    },
    {
      "<leader>pq",
      function()
        require("persistence").stop()
      end,
      desc = "Quit without saving session",
    },
  }
end

local function get_toggleterm_keymaps()
  return {
    { [[<c-\>]], desc = "Toggle Terminal" },
  }
end

-- Buffer Management
local function get_buffer_keymaps()
  return {
    { "<leader>bd", "<cmd>Bdelete<cr>", desc = "Delete Buffer" },
    { "<leader>bD", "<cmd>Bwipeout<cr>", desc = "Wipeout Buffer" },
    { "<leader>ba", "<cmd>%bd|e#|bd#<cr>", desc = "Delete All Buffers But Current" },
  }
end

-- File Management
local function get_oil_keymaps()
  return {
    ["<M-h>"] = "actions.select_split",
    ["<M-v>"] = "actions.select_vsplit",
    ["<M-t>"] = "actions.select_tab",
    ["<M-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-r>"] = "actions.refresh",
    ["g?"] = "actions.show_help",
  }
end

-- ============================================================================
-- PLUGIN SETUP FUNCTIONS (Traditional map() style for buffer-specific keymaps)
-- ============================================================================

-- Git Operations (Gitsigns) - Buffer specific
local function setup_git_keymaps(bufnr)
  local gitsigns = require("gitsigns")

  -- Hunk Navigation
  map("n", "]c", function()
    if vim.wo.diff then
      vim.cmd.normal({ "]c", bang = true })
    else
      gitsigns.nav_hunk("next")
    end
  end, { desc = "Next git hunk" }, bufnr)

  map("n", "[c", function()
    if vim.wo.diff then
      vim.cmd.normal({ "[c", bang = true })
    else
      gitsigns.nav_hunk("prev")
    end
  end, { desc = "Previous git hunk" }, bufnr)

  -- Stage/Reset Operations
  map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" }, bufnr)
  map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" }, bufnr)
  map("v", "<leader>hs", function()
    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, { desc = "Stage hunk (visual)" }, bufnr)
  map("v", "<leader>hr", function()
    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, { desc = "Reset hunk (visual)" }, bufnr)

  -- Buffer Operations
  map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" }, bufnr)
  map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" }, bufnr)

  -- Preview & Information
  map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" }, bufnr)
  map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" }, bufnr)
  map("n", "<leader>hb", function()
    gitsigns.blame_line({ full = true })
  end, { desc = "Blame line" }, bufnr)

  -- Diff Operations
  map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff this" }, bufnr)
  map("n", "<leader>hD", function()
    gitsigns.diffthis("~")
  end, { desc = "Diff this (cached)" }, bufnr)

  -- Quickfix Integration
  map("n", "<leader>hQ", function()
    gitsigns.setqflist("all")
  end, { desc = "Send all hunks to quickfix" }, bufnr)
  map("n", "<leader>hq", gitsigns.setqflist, { desc = "Send hunks to quickfix" }, bufnr)

  -- Toggles
  map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" }, bufnr)
  map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle word diff" }, bufnr)

  -- Text Objects
  map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select hunk" }, bufnr)
end

-- LSP Operations - Buffer specific
local function setup_lsp_keymaps(bufnr)
  local has_telescope = pcall(require, "telescope.builtin")

  vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

  if has_telescope then
    local builtin = require("telescope.builtin")
    map("n", "gd", builtin.lsp_definitions, { desc = "Go to definition" }, bufnr)
    map("n", "gi", builtin.lsp_implementations, { desc = "Go to implementation" }, bufnr)
    map("n", "gr", builtin.lsp_references, { desc = "Go to references" }, bufnr)
    map("n", "gT", builtin.lsp_type_definitions, { desc = "Go to type definition" }, bufnr)
    map("n", "gs", builtin.lsp_document_symbols, { desc = "Document symbols" }, bufnr)
  else
    -- Fallback to built-in LSP functions
    map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" }, bufnr)
    map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" }, bufnr)
    map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" }, bufnr)
    map("n", "gT", vim.lsp.buf.type_definition, { desc = "Go to type definition" }, bufnr)
  end

  map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" }, bufnr)
  map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" }, bufnr)
  map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" }, bufnr)
  map("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" }, bufnr)
  map("n", "ga", vim.lsp.buf.code_action, { desc = "Code actions" }, bufnr)
  map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" }, bufnr)
end

-- Aerial Buffer Keymaps
local function setup_aerial_buffer_keymaps(bufnr)
  map("n", "{", "<cmd>AerialPrev<CR>", { desc = "Previous aerial symbol" }, bufnr)
  map("n", "}", "<cmd>AerialNext<CR>", { desc = "Next aerial symbol" }, bufnr)
end

-- ============================================================================
-- GLOBAL SETUP FUNCTIONS (Non-lazy loading)
-- ============================================================================

-- Code Formatting
local function setup_formatting_keymaps()
  map({ "n", "v" }, "<space>f", function()
    require("conform").format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 500,
    })
  end, { desc = "Format code" })
end

-- Diagnostic Management
local function setup_diagnostic_keymaps()
  vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
  map("", "<leader>l", function()
    local config = vim.diagnostic.config() or {}
    if config.virtual_text then
      vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
    else
      vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
    end
  end, { desc = "Toggle lsp_lines" })
end

-- ============================================================================
-- DEFERRED SETUP
-- ============================================================================
local function setup_deferred_keymaps()
  defer_setup(function()
    -- Only setup if plugins are actually loaded
    if package.loaded["telescope"] then
      -- Already handled by keys
    end
    if package.loaded["harpoon"] then
      -- Already handled by keys
    end
  end, 200)
end

-- ============================================================================
-- EXPORTED FUNCTIONS
-- ============================================================================

local M = {}

-- Plugin keymaps for lazy loading (return keys tables)
M.get_telescope_keymaps = get_telescope_keymaps
M.get_harpoon_keymaps = get_harpoon_keymaps
M.get_trouble_keymaps = get_trouble_keymaps
M.get_aerial_keymaps = get_aerial_keymaps
M.get_refactoring_keymaps = get_refactoring_keymaps
M.get_hlslens_keymaps = get_hlslens_keymaps
M.get_neogit_keymaps = get_neogit_keymaps
M.get_git_enhanced_keymaps = get_git_enhanced_keymaps
M.get_noice_keymaps = get_noice_keymaps
M.get_which_key_keymaps = get_which_key_keymaps
M.get_copilot_keymaps = get_copilot_keymaps
M.get_neotest_keymaps = get_neotest_keymaps
M.get_todo_keymaps = get_todo_keymaps
M.get_persistence_keymaps = get_persistence_keymaps
M.get_toggleterm_keymaps = get_toggleterm_keymaps
M.get_buffer_keymaps = get_buffer_keymaps
M.get_oil_keymaps = get_oil_keymaps

-- Buffer-specific setup functions (traditional map() style)
M.setup_git = setup_git_keymaps
M.setup_lsp = setup_lsp_keymaps
M.setup_aerial_buffer = setup_aerial_buffer_keymaps

-- Global setup functions
M.setup_formatting = setup_formatting_keymaps
M.setup_diagnostic = setup_diagnostic_keymaps

setup_deferred_keymaps()
return M
