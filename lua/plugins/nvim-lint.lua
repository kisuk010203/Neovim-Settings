return {
  "mfussenegger/nvim-lint",
  event = { "BufWritePost", "BufReadPost", "InsertLeave" },
  config = function()
    -- Ensure linters are installed via mason-tool-installer
    local ok, registry = pcall(require, "mason-registry")
    if ok then
      for _, pkg_name in ipairs({ "ruff", "cppcheck" }) do
        if not registry.is_installed(pkg_name) then
          local pkg = registry.get_package(pkg_name)
          pkg:install()
        end
      end
    end

    local lint = require("lint")
    lint.linters_by_ft = {
      python = { "ruff" },
      c      = { "cppcheck" },
      cpp    = { "cppcheck" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
