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

local function print_to_buf(buf, output)
  local lines = type(output) == "string" and vim.split(output, "\n") or output
  vim.api.nvim_buf_set_lines(buf, -1, -1, false, lines)
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

function GoGenerate()
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir = vim.fn.fnamemodify(current_file, ":p:h")
  local file_content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local go_generate_instructions = {}
  local thread_locked = false

  for _, line in ipairs(file_content) do
    if line:match("^%s*//go:generate") then
      table.insert(go_generate_instructions, line)
    end
  end

  local function lock_thread()
    thread_locked = true
  end

  local function unlock_thread()
    thread_locked = false
  end

  local function print_error(buf, error)
    print_to_buf(buf, "💔 ERROR!")
    print_to_buf(buf, error)
  end

  local function print_result(buf, result)
    print_to_buf(buf, "✅ DONE!")
    print_to_buf(buf, result)
  end

  local function execute_command(command, buf)
    vim.schedule(function()
      print_to_buf(buf, "Executing: " .. command .. ". Please wait.")
    end)

    lock_thread()

    vim.defer_fn(function()
      local success, result = pcall(vim.fn.system, "cd " .. current_dir .. " && " .. command)

      vim.schedule(function()
        if success then
          -- check for error exit code
          if vim.v.shell_error ~= 0 then
            print_error(buf, result)

            unlock_thread()
            return
          end

          if result == "" then
            result = "[No output]\n"
          end

          print_result(buf, result)
        else
          print_error(buf, result)
        end
        unlock_thread()
      end)
    end, 10)
  end

  local function if_locked_retry_until_unlocked(command)
    if thread_locked then
      vim.defer_fn(function()
        if_locked_retry_until_unlocked(command)
      end, 500)
    else
      command()
    end
  end

  if #go_generate_instructions == 0 then
    vim.notify("No go:generate instruction found in the current file", vim.log.levels.WARN)
    return
  else
    local buf =
      CreateFloatingWindow("Running " .. #go_generate_instructions .. " go:generate instruction(s) in " .. current_dir)

    print_to_buf(buf, "=======================================\n\n")

    -- Schedule the execution of instructions
    vim.schedule(function()
      for _, instruction in ipairs(go_generate_instructions) do
        local command = instruction:gsub("//go:generate%s*", "")

        -- if command contains $GOFILE, replace it with the current file
        command = command:gsub("%$GOFILE", current_file)

        if_locked_retry_until_unlocked(function()
          execute_command(command, buf)
        end)
      end

      if_locked_retry_until_unlocked(function()
        print_to_buf(buf, "===================================")
        print_to_buf(buf, "🚀 FINISHED! " .. #go_generate_instructions .. " instruction(s) executed")
      end)
    end)
  end
end

vim.api.nvim_create_user_command("GoGenerate", GoGenerate, {})

-- run go test for curent file
function GoTest()
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir = vim.fn.fnamemodify(current_file, ":p:h")
  local command = "cd " .. current_dir .. " && go test -v"

  local buf = CreateFloatingWindow("Running 'go test -v' in: " .. current_dir)
  print_to_buf(buf, "=======================================\n")

  -- Run the test command and capture the output
  vim.fn.jobstart(command, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        vim.schedule(function()
          vim.api.nvim_buf_set_option(buf, "modifiable", true)
          print_to_buf(buf, data)
          vim.api.nvim_buf_set_option(buf, "modifiable", false)
        end)
      end
    end,
    on_stderr = function(_, data)
      if data then
        vim.schedule(function()
          vim.api.nvim_buf_set_option(buf, "modifiable", true)
          print_to_buf(buf, data)
          vim.api.nvim_buf_set_option(buf, "modifiable", false)
        end)
      end
    end,
  })
end

vim.api.nvim_create_user_command("GoTest", GoTest, {})

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
