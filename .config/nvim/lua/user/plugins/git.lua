return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      local gitsigns = require("gitsigns")
      local keymap = vim.keymap.set

      gitsigns.setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })

      keymap("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { desc = "Preview git hunk" })
      keymap("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle blame line" })
    end,
  },
}
