return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Workspace diagnostics" },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Document diagnostics" },
    { "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix list" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location list" },
  },
  opts = {},
}
