return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, noremap = true, silent = true, desc = desc })
        end

        -- Navigation
        map("n", "]h", gs.next_hunk, "Next hunk")
        map("n", "[h", gs.prev_hunk, "Prev hunk")

        -- Actions
        map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>gb", gs.toggle_current_line_blame, "Toggle line blame")
        map("n", "<leader>gd", gs.diffthis, "Diff this")
      end,
    })

    -- Refresh gitsigns and neo-tree when a terminal job finishes (e.g. after git commit)
    vim.api.nvim_create_autocmd("TermClose", {
      callback = function()
        require("gitsigns").refresh()
        local ok, manager = pcall(require, "neo-tree.sources.manager")
        if ok then manager.refresh("filesystem") end
      end,
    })
  end,
}
