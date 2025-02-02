return {
  {
    "tpope/vim-commentary",
    event = { "BufReadPre", "BufNewFile" },
  },
  "tpope/vim-surround",
  "tpope/vim-repeat",
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
}
