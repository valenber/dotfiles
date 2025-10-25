return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    indent = {
      enabled = true,
      char = "┊",
    },
    gitbrowse = {
      enabled = true,
      -- Transform github.com-qonto remote to standard GitHub URLs
      remote_patterns = {
        { "^git@github%.com%-qonto:(.+)%.git$", "https://github.com/%1" },
        { "^git@github%.com%-qonto:(.+)$", "https://github.com/%1" },
      },
    },
  },
  keys = {
    {
      "<leader>gy",
      function()
        local line = vim.fn.line(".")
        Snacks.gitbrowse({
          line_start = line,
          line_end = line,
          notify = false,
          open = function(url)
            vim.fn.setreg("+", url)
            vim.notify("Copied URL to clipboard", vim.log.levels.INFO)
          end,
        })
      end,
      desc = "Copy git URL to clipboard with line number",
      mode = { "n", "v" },
    },
  },
}
