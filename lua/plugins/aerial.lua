return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("aerial").setup({
      backends = { "lsp", "treesitter" },
      layout = {
        default_direction = "right",
        max_width = { 40, 0.2 },
        min_width = 30,
      },
      attach_mode = "global",
      show_guides = true,
    })

    require("telescope").load_extension("aerial")

    local mapKey = require("utils.keyMapper").mapKey
    mapKey("<leader>o", "<cmd>AerialToggle<cr>")
    mapKey("<leader>fs", "<cmd>Telescope aerial<cr>")
  end,
}
