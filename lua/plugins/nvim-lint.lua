return {
  "mfussenegger/nvim-lint",
  event = { "BufWritePost", "BufReadPost", "InsertLeave" },
  config = function()
    -- Ensure linters are installed via mason-tool-installer
    local ok, registry = pcall(require, "mason-registry")
    if ok and not registry.is_installed("ruff") then
      registry.get_package("ruff"):install()
    end

    local lint = require("lint")
    lint.linters_by_ft = {
      python = { "ruff" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
