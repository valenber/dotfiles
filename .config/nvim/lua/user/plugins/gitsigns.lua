return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      current_line_blame = false, -- Toggle with :Gitsigns toggle_current_line_blame
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
      },
    })

    -- Keymaps
    vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame<cr>", { desc = "Blame line" })
    vim.keymap.set("n", "<leader>gt", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle line blame" })
  end,
}
