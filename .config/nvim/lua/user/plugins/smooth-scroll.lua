return {
  "karb94/neoscroll.nvim", -- smooth scroll
  config = function()
    local neoscroll = require("neoscroll")

    neoscroll.setup({
      easing_function = "circular",
      respect_scrolloff = false,
      stop_eof = false,
    })
  end,
}
