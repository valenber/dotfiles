return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      cmdline = {
        view = "cmdline",
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            find = "written",
          },
          action = "close",
        },
        {
          filter = {
            event = "msg_show",
            find = "more lines",
          },
          action = "close",
        },
        {
          filter = {
            event = "msg_show",
            find = "fewer lines",
          },
          action = "close",
        },
        {
          filter = {
            event = "msg_show",
            find = "more line",
          },
          action = "close",
        },
      },
    })
  end,
}
