return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    vim.lsp.set_log_level("off") -- disable logging

    mason_lspconfig.setup({
      ensure_installed = { "lua_ls", "ts_ls", "html", "emmet_ls", "pyright" },
      automatic_installation = true,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        -- formatters
        "prettier",
        "stylua",
        "yamlfmt",
        -- linters
        "eslint_d",
        "jsonlint",
        "luacheck",
        "markdownlint",
        "stylelint",
      },
    })
  end,
}
