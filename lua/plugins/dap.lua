return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "jay-babu/mason-nvim-dap.nvim",
    },
    keys = {
      { "<F5>",       function() require("dap").continue() end,                                            desc = "Debug: continue" },
      { "<F10>",      function() require("dap").step_over() end,                                           desc = "Debug: step over" },
      { "<F11>",      function() require("dap").step_into() end,                                           desc = "Debug: step into" },
      { "<F12>",      function() require("dap").step_out() end,                                            desc = "Debug: step out" },
      { "<leader>b",  function() require("dap").toggle_breakpoint() end,                                   desc = "Toggle breakpoint" },
      { "<leader>B",  function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end,           desc = "Conditional breakpoint" },
      { "<leader>du", function() require("dapui").toggle() end,                                            desc = "Toggle DAP UI" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- DAP UI: open/close automatically with debug sessions
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      -- codelldb adapter (C, C++, Rust) — installed by mason-nvim-dap
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      }

      local codelldb_config = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.c   = codelldb_config
      dap.configurations.cpp = codelldb_config
      dap.configurations.rust = vim.deepcopy(codelldb_config)

      -- debugpy adapter (Python) — installed by mason-nvim-dap
      dap.adapters.python = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
        args = { "-m", "debugpy.adapter" },
      }
      dap.configurations.python = {
        {
          name = "Launch file",
          type = "python",
          request = "launch",
          program = "${file}",
          pythonPath = function()
            local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
            if venv then return venv .. "/bin/python" end
            return vim.fn.exepath("python3") or "python3"
          end,
        },
      }
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "codelldb", "debugpy" },
      handlers = {},
    },
  },
}
