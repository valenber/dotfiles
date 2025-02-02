return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local keymap = vim.keymap

    local function on_attach(buf_num)
      -- set keymaps
      local opts = { noremap = true, silent = true, nowait = true, buffer = buf_num }
      local api = require("nvim-tree.api")

      local function edit_or_open()
        local node = api.tree.get_node_under_cursor()

        if node.nodes ~= nil then
          -- expand or collapse folder
          api.node.open.edit()
        else
          -- open file
          api.node.open.edit()
          -- close the tree if file was opened
          api.tree.focus()
        end
      end

      local function vsplit_preview()
        local node = api.tree.get_node_under_cursor()

        if node.nodes ~= nil then
          -- expand or collapse folder
          api.node.open.edit()
        else
          -- open file as vsplit
          api.node.open.vertical()
        end

        -- close the tree if file was opened
        api.tree.focus()
      end

      api.config.mappings.default_on_attach(buf_num) -- default nvim-tree mappings

      keymap.set("n", "l", edit_or_open, opts)
      keymap.set("n", "L", vsplit_preview, opts)
    end

    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- configure nvim-tree
    nvimtree.setup({
      on_attach = on_attach,
      view = {
        width = 52,
        relativenumber = true,
      },
      renderer = {
        group_empty = true,
        indent_markers = {
          enable = true,
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>") -- toggle file explorer
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>") -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>") -- collapse folders in file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>") -- refresh file explorer
  end,
}
