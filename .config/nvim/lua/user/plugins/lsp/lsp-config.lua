return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local keymap = vim.keymap.set

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        keymap("n", "gd", vim.lsp.buf.definition, opts)
        keymap("n", "<Leader>cd", vim.diagnostic.open_float, opts)
        keymap("n", "K", vim.lsp.buf.hover, opts)
        keymap("n", "<Leader>rn", vim.lsp.buf.rename, opts)
        keymap({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, opts)
        keymap("n", "<Leader>rs", ":LspRestart<cr>", opts)
      end,
    })

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- NOTE: these symbols are also used in lua/user/plugins/lualine.lua (lualine_c diagnostics)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

    -- NOTE: virtual_lines config is in lua/user/core/options.lua
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = signs.Error,
          [vim.diagnostic.severity.WARN] = signs.Warn,
          [vim.diagnostic.severity.HINT] = signs.Hint,
          [vim.diagnostic.severity.INFO] = signs.Info,
        },
      },
    })
  end,
}
