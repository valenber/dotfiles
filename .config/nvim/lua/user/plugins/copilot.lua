return {
  "github/copilot.vim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local keymap = vim.keymap.set
    local opts = { expr = true, silent = true }

    keymap("i", "<A-s>", "copilot#Next()", opts)
    keymap("i", "<A-a>", "copilot#Previous()", opts)
  end,
}
