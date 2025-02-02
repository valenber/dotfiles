local opt = vim.opt

opt.wrap = true
opt.swapfile = false
opt.number = true
opt.relativenumber = true
opt.scrolloff = 8
opt.clipboard = "unnamedplus" -- share system clipboard
opt.cursorline = true

-- use spaces for tabs etc
opt.tabstop = 2
opt.shiftwidth = 2
opt.shiftround = true
opt.expandtab = true
opt.hlsearch = true

-- looks
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- keep undo history across sessions
opt.undofile = true

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
opt.completeopt = "menuone,noselect"

-- search case insensitive esc
opt.ignorecase = true
