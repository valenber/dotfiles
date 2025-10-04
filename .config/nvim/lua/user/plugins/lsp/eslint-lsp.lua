return {
  "neovim/nvim-lspconfig",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  config = function()
    local lspconfig = require("lspconfig")

    lspconfig.eslint.setup({
      settings = {
        -- Enable ESLint for all supported languages
        workingDirectories = { mode = "auto" },
      },
      -- Ensure it works in monorepo by finding the correct root
      root_dir = lspconfig.util.root_pattern(
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.json",
        "eslint.config.js",
        "package.json"
      ),
    })
  end,
}
