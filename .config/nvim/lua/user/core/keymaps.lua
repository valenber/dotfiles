local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- return to normal mode
keymap("i", "jk", "<Esc>", opts)
keymap("v", "jk", "<Esc>", opts)

-- buffers navigation
keymap("n", "<C-s>", ":bnext<CR>", opts)
keymap("n", "<C-a>", ":bprevious<CR>", opts)

-- splits
keymap("n", "<leader>-", ":split<CR>", opts)
keymap("n", "<leader>|", ":vsplit<CR>", opts)
keymap("n", "<leader>sd", "<C-w>q", opts) -- close split
keymap("n", "<leader>se", "<C-w>=", opts) -- adjust splits to be even
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")
keymap("n", "<leader>h", ":vertical resize -4<CR>", opts)
keymap("n", "<leader>l", ":vertical resize +4<CR>", opts)
-- Close the current buffer without closing the split
keymap("n", "<leader>bd", ":bp<bar>sp<bar>bn<bar>bd<CR>", opts)

-- sort highlighted lines
keymap("v", "<C-s>", ":sort<CR>", { silent = true })

-- move visually over wrapped text
keymap("n", "j", "gj", { silent = true })
keymap("n", "k", "gk", { silent = true })
