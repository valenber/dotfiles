return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-tree/nvim-web-devicons",
      "folke/todo-comments.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")

      local keymap = vim.keymap.set

      telescope.setup({
        defaults = {
          path_display = { "smart" },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              ["<C-j>"] = actions.move_selection_next, -- move to next result
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- open results in quickfix list
            },
          },
        },
      })

      telescope.load_extension("fzf")

      -- toggle tmux pane zoom when telescope is opened
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "TelescopePrompt",
        callback = function()
          local tmux_pane_zoomed = vim.fn.system("tmux display-message -p '#{window_zoomed_flag}'"):gsub("%s+", "")
            == "1"

          if not tmux_pane_zoomed then
            ToggleTmuxZoom()
            vim.b.telescope_zoomed = true
          end
        end,
      })

      -- toggle tmux pane when telescope is closed
      vim.api.nvim_create_autocmd("WinClosed", {
        callback = function(args)
          local win_id = tonumber(args.match)
          local buf = vim.api.nvim_win_get_buf(win_id)
          local buf_type = vim.api.nvim_buf_get_option(buf, "buftype")
          local buf_filetype = vim.api.nvim_buf_get_option(buf, "filetype")

          if buf_type == "prompt" and buf_filetype == "TelescopePrompt" then
            if vim.b.telescope_zoomed then
              ToggleTmuxZoom()
              vim.b.telescope_zoomed = nil
            end
          end
        end,
      })

      keymap("n", "<Leader>ff", builtin.find_files)
      keymap("n", "<Leader>fo", builtin.oldfiles)
      keymap("n", "<Leader>sg", builtin.live_grep)
      keymap("n", "<Leader>ss", builtin.grep_string)
      keymap("n", "<Leader>sh", builtin.help_tags)
      keymap("n", "<Leader>ft", "<cmd>TodoTelescope<CR>")
      keymap("n", "<Leader>fb", builtin.buffers)
      keymap("n", "gr", builtin.lsp_references)
    end,
  },
}
