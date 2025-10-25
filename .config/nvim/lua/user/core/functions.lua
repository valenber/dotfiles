-- remove search highlight when moving cursor
local keymap = vim.keymap.set
local options = { noremap = true }

-- remove search highlight
keymap("n", "<Esc>", ":noh<CR>", options)

-- highlight yanked text
vim.api.nvim_set_hl(0, "YankHighlight", { fg = "#171f40", bg = "#bfa95b" })
vim.cmd([[
  augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank({higroup="YankHighlight", timeout=400})
  augroup END
]])

vim.cmd([[
  augroup markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal textwidth=80
    autocmd FileType markdown setlocal formatoptions+=t
  augroup END
]])

-- GLOBAL HELPERS
-- toggle diagnostics in current buffer
function ToggleBufferDiagnostics()
  local bufnr = vim.api.nvim_get_current_buf()
  -- Get the current state of diagnostics for this buffer
  local diagnostics_enabled = vim.b[bufnr].diagnostics_enabled

  if diagnostics_enabled == nil then
    -- Initialize the state if it doesn't exist
    diagnostics_enabled = true
  end

  if diagnostics_enabled then
    vim.diagnostic.disable(bufnr)
    diagnostics_enabled = false
    print("LSP diagnostics disabled")
  else
    vim.diagnostic.enable(bufnr)
    diagnostics_enabled = true
    print("LSP diagnostics enabled")
  end

  -- Save the updated state back to the buffer-local variable
  vim.b[bufnr].diagnostics_enabled = diagnostics_enabled
end

keymap("n", "<leader>cdd", ToggleBufferDiagnostics, options)

-- toggle tmux pane zoom
function ToggleTmuxZoom()
  vim.cmd("silent !tmux resize-pane -Z")
end

function CreateFloatingWindow(title)
  -- Create a new buffer for the floating window
  local buf = vim.api.nvim_create_buf(false, true)

  -- Open a centered floating window
  local width = math.floor(vim.o.columns * 0.75)
  local height = math.floor(vim.o.lines * 0.75)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local opts = {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  }

  local win = vim.api.nvim_open_win(buf, true, opts)

  if title then
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, type(title) == "table" and title or { title })
  end

  -- Add a keymap to close the window
  vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, "t", "jk", "<C-\\><C-n>", { noremap = true, silent = true })

  -- Return the buffer and window handles
  return buf, win
end

-- open terminal in current buffer folder in a floating window
function OpenTerminal()
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir = vim.fn.fnamemodify(current_file, ":p:h")

  CreateFloatingWindow()

  -- Open terminal in the floating window
  vim.fn.termopen(vim.o.shell, { cwd = current_dir })

  -- Enter insert mode
  vim.cmd("startinsert")
end

vim.api.nvim_create_user_command("OpenTerminal", OpenTerminal, {})
keymap("n", "<leader>tt", OpenTerminal, options)

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    -- Skip special buffers (gitsigns, terminals, etc.)
    local buftype = vim.bo.buftype
    if buftype ~= "" then
      return
    end

    -- Skip if buffer has no name
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname == "" then
      return
    end

    -- Skip if the file doesn't exist (temporary/special buffers)
    if vim.fn.filereadable(bufname) == 0 then
      return
    end

    local function find_project_root()
      local markers = { ".git", "package.json", "tsconfig.json" }
      local current = vim.fn.expand("%:p:h")

      while current ~= "/" do
        for _, marker in ipairs(markers) do
          if vim.fn.findfile(marker, current) ~= "" or vim.fn.finddir(marker, current) ~= "" then
            return current
          end
        end
        current = vim.fn.fnamemodify(current, ":h")
      end
      return nil
    end

    local root = find_project_root()
    if root then
      vim.cmd("lcd " .. root)
    end
  end,
})
