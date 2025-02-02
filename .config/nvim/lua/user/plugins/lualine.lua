return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")
    local lint = require("lint")

    local lint_progress = function()
      local linters = lint.get_running()
      if #linters == 0 then
        return "󰈈"
      end
      return " " .. table.concat(linters, ", ")
    end

    lualine.setup({
      options = {
        icons_enabled = true,
        theme = "onedark",
      },
      sections = {
        lualine_a = {
          {
            "filename",
            path = 1,
          },
        },
        lualine_b = {
          {
            "branch",
            icon = "",
          },
        },
        lualine_c = {
          {
            "diagnostics",
            sources = { "nvim_lsp" },
            symbols = { error = " ", warn = " ", hint = "󰠠 ", info = " " },
          },
        },
        lualine_x = {
          {
            lint_progress,
            cond = lazy_status.has_lint,
            color = { fg = "#ff9e64" },
          },
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
        },
        lualine_y = {
          {
            "filetype",
            colored = true,
          },
        },
        lualine_z = {
          {
            "progress",
          },
        },
      },
    })
  end,
}
