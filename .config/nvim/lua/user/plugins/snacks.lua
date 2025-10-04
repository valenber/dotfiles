return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    indent = {
      enabled = true,
      char = "┊",
    },
    scroll = {
      enabled = true,
      animate = {
        easing = "inOutCirc",
      },
    },
    gitbrowse = {
      enabled = true,
      -- Transform github.com-qonto remote to standard GitHub URLs
      remote_patterns = {
        { "^git@github%.com%-qonto:(.+)%.git$", "https://github.com/%1" },
        { "^git@github%.com%-qonto:(.+)$", "https://github.com/%1" },
      },
    },
    git = {
      enabled = true,
    },
    styles = {
      blame_line = {
        width = 0.6,
        height = 0.6,
        border = "rounded",
        title = " Git Blame ",
        title_pos = "center",
        ft = "git",
        wo = {
          winhighlight = "NormalFloat:Normal,FloatBorder:Normal",
        },
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
    {
      "<leader>gt",
      function()
        Snacks.git.blame_line()
      end,
      desc = "Git blame line",
    },
  },
}
