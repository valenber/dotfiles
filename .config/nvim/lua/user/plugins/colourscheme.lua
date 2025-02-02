return {
  "rebelot/kanagawa.nvim",
  priority = 1000,
  config = function()
    local kanagawa = require("kanagawa")

    -- why not comment something here
    kanagawa.setup({
      transparent = true,
      commentStyle = { italic = true, bold = true },
    })

    vim.cmd("colorscheme kanagawa-wave")
  end,
}
