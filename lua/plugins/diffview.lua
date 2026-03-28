return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  keys = {
    {
      "<leader>gv",
      function()
        local lib = require("diffview.lib")
        local view = lib.get_current_view()
        if view then
          vim.cmd("DiffviewClose")
        else
          vim.cmd("DiffviewOpen")
        end
      end,
      desc = "Toggle Diffview",
    },
    { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
  },
  config = true,
}
