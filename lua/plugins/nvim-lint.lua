return {
  "mfussenegger/nvim-lint",
  event = { "BufWritePost", "BufReadPost", "InsertLeave" },
  config = function()
    -- Ensure linters are installed via mason-registry
    local ok, registry = pcall(require, "mason-registry")
    if ok then
      for _, pkg in ipairs({ "ruff", "eslint_d" }) do
        if not registry.is_installed(pkg) then
          registry.get_package(pkg):install()
        end
      end
    end

    local lint = require("lint")
    lint.linters_by_ft = {
      python = { "ruff" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
