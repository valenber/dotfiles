return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",
  config = function()
    require("neoscroll").setup({
      mappings = { "<C-u>", "<C-d>", "zt", "zz", "zb" },
      hide_cursor = true,
      stop_eof = false,
      easing_function = "circular",
      duration_multiplier = 0.75,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
    })
  end,
}
