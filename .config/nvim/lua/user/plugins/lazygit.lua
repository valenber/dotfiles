-- toggle tmux zoom and open lazygit
local function OpenWithTmuxZoom()
  ToggleTmuxZoom()

  vim.defer_fn(function()
    require("lazygit").lazygit()
  end, 100)
end

-- toggle tmux zoom when lazygit is closed
vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "*lazygit*",
  callback = function()
    local tmux_pane_zoomed = vim.fn.system("tmux display-message -p '#{window_zoomed_flag}'"):gsub("%s+", "") == "1"

    if tmux_pane_zoomed then
      ToggleTmuxZoom()
    end
  end,
})

return {
  "kdheepak/lazygit.nvim",
  -- optional for floating window border decoration
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>lg", OpenWithTmuxZoom },
  },
}
