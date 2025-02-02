return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

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

    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    mason_lspconfig.setup_handlers({
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      -- custom configs for language servers
      ["stylelint_lsp"] = function()
        lspconfig["stylelint_lsp"].setup({
          capabilities = capabilities,
          filetypes = {
            "css",
            "sass",
            "scss",
            "less",
          },
        })
      end,
      ["emmet_ls"] = function()
        lspconfig["emmet_ls"].setup({
          capabilities = capabilities,
          filetypes = {
            "html",
            "typescriptreact",
            "javascriptreact",
            "css",
            "sass",
            "scss",
            "less",
            "svelte",
          },
        })
      end,
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              -- make the language server recognize "vim" global
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
      ["ember"] = function()
        lspconfig["ember"].setup({
          capabilities = capabilities,
          settings = {
            ember = {
              templateLinting = true,
              ignoreFilesOnServerStart = {
                "node_modules/**",
                "tmp/**",
              },
            },
          },
        })
      end,
    })
  end,
}
