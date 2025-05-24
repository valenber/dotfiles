local home = vim.fn.expand("$HOME")

local function CustomAvanteAsk()
  local tmux_pane_zoomed = vim.fn.system("tmux display-message -p '#{window_zoomed_flag}'"):gsub("%s+", "") == "1"

  if tmux_pane_zoomed then
    require("avante.api").ask()

    vim.defer_fn(function()
      ToggleTmuxZoom()
    end, 100)
  else
    ToggleTmuxZoom()

    vim.defer_fn(function()
      require("avante.api").ask()
    end, 100)
  end
end

local config = {
  "yetone/avante.nvim",
  branch = "main",
  event = "VeryLazy",
  keys = {
    {
      "<leader>aa",
      CustomAvanteAsk,
      desc = "avante: ask",
      mode = { "n", "v" },
    },
    {
      "<leader>ar",
      function()
        require("avante.api").refresh()
      end,
      desc = "avante: refresh",
    },
    {
      "<leader>ae",
      function()
        require("avante.api").edit()
      end,
      desc = "avante: edit",
      mode = "v",
    },
  },
  opts = {
    windows = {
      width = 40,
    },
    provider = "copilot",
    copilot = {
      model = "claude-3.7-sonnet",
    },
    claude = {
      api_key_name = "cmd: gpg --decrypt " .. home .. "/.config/nvim/claude.key.gpg",
    },
    openai = {
      api_key_name = "cmd: gpg --decrypt " .. home .. "/.config/nvim/openai.key.gpg",
    },
    mappings = {
      ask = "<leader>aa",
      sidebar = {
        switch_windows = "<leader>]",
        reverse_switch_windows = "<leader>[",
      },
    },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          -- use_absolute_path = true,
        },
      },
    },
    --- The below is optional, make sure to setup it properly if you have lazy=true
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}

return config
